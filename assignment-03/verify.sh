#!/usr/bin/env bash
set -e
# =============================================================================
# ShopFlow Assignment 3 - Query Verification Script
# =============================================================================
# This script validates student SQL submissions by checking:
# 1. SQL syntax is correct (queries execute without errors)
# 2. Queries return results (not empty)
# 3. Expected number of queries per exercise
#
# Usage: 
#   - Local (Windows/Mac/Linux): docker-compose run --rm verify
#   - GitHub Actions: bash ./verify.sh
# =============================================================================

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Configuration
CONTAINER_NAME="${CONTAINER_NAME:-postgres}"
DB_USER="${PGUSER:-postgres}"
DB_NAME="${PGDATABASE:-postgres}"

# Detect if running inside container or on host
if [ -n "$PGHOST" ]; then
    # Running inside container (docker-compose run verify)
    RUN_MODE="container"
    DB_HOST="$PGHOST"
    SQL_DIR="/sql"
else
    # Running on host (GitHub Actions or local bash)
    RUN_MODE="host"
    SQL_DIR="./sql"
fi

OUTPUT_DIR="/tmp/output"

# Score tracking
TOTAL_POINTS=0
MAX_POINTS=100

# Points per exercise
POINTS_EX1=20
POINTS_EX2=20
POINTS_EX3=20
POINTS_EX4=20
POINTS_EX5=20

echo "========================================"
echo "  ShopFlow Assignment 3 - Verification"
echo "========================================"
echo ""

# Create output directory
mkdir -p "$OUTPUT_DIR"

# Function to run SQL file and return exit code
run_sql_file() {
    local sql_file="$1"
    local output_file="$2"
    if [ "$RUN_MODE" = "container" ]; then
        psql -h "$DB_HOST" -U "$DB_USER" -d "$DB_NAME" -f "$sql_file" > "$output_file" 2>&1
        return $?
    else
        docker exec -i "$CONTAINER_NAME" psql -U "$DB_USER" -d "$DB_NAME" < "$sql_file" > "$output_file" 2>&1
        return $?
    fi
}

# Function to print test result
print_result() {
    local test_name=$1
    local passed=$2
    local points=$3

    if [ "$passed" = true ]; then
        echo -e "${GREEN}PASS${NC}: $test_name (+$points pts)"
        TOTAL_POINTS=$((TOTAL_POINTS + points))
    else
        echo -e "${RED}FAIL${NC}: $test_name (0/$points pts)"
    fi
}

# Function to verify an exercise file
verify_exercise() {
    local exercise_num=$1
    local exercise_name=$2
    local points=$3
    local expected_queries=$4
    
    local exercise_file="$SQL_DIR/exercise_0${exercise_num}.sql"
    local output_file="$OUTPUT_DIR/output_ex${exercise_num}.txt"
    
    if [ ! -f "$exercise_file" ]; then
        echo -e "${YELLOW}⚠ SKIP${NC}: Exercise $exercise_num - File not found (0/$points pts)"
        return
    fi
    
    # Run the SQL file
    if ! run_sql_file "$exercise_file" "$output_file"; then
        echo -e "${RED}FAIL${NC}: Exercise $exercise_num: $exercise_name - SQL syntax error (0/$points pts)"
        grep -i "error\|ERROR" "$output_file" 2>/dev/null | head -3 || true
        return
    fi
    
    # Check for errors in output
    if grep -qi "error" "$output_file"; then
        echo -e "${RED}FAIL${NC}: Exercise $exercise_num: $exercise_name - SQL error (0/$points pts)"
        grep -i "error" "$output_file" | head -3
        return
    fi
    
    # Count SELECT results (look for row count lines like "(X rows)")
    local result_count
    result_count=$(grep -c "rows\?)" "$output_file" 2>/dev/null) || result_count=0
    
    if [ "$result_count" -lt "$expected_queries" ]; then
        echo -e "${RED}FAIL${NC}: Exercise $exercise_num: $exercise_name - Expected $expected_queries queries, found $result_count (0/$points pts)"
        return
    fi
    
    # Check that queries return data (not all empty)
    local empty_results
    empty_results=$(grep -c "(0 rows)" "$output_file" 2>/dev/null) || empty_results=0
    
    if [ "$empty_results" -eq "$expected_queries" ]; then
        echo -e "${RED}FAIL${NC}: Exercise $exercise_num: $exercise_name - All queries returned empty results (0/$points pts)"
        return
    fi
    
    print_result "Exercise $exercise_num: $exercise_name" true $points
}

# ============================================
# STEP 1: Check environment
# ============================================
echo "----------------------------------------"
echo "Step 1: Checking database connection..."
echo "----------------------------------------"

if [ "$RUN_MODE" = "container" ]; then
    if ! psql -h "$DB_HOST" -U "$DB_USER" -d "$DB_NAME" -c "SELECT 1" > /dev/null 2>&1; then
        echo -e "${RED}Error: Cannot connect to database.${NC}"
        echo "Please make sure the database is running with: docker-compose up -d"
        exit 1
    fi
else
    # Start docker compose if postgres is not running
    if ! docker ps --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
        echo "Starting PostgreSQL via docker compose..."
        docker compose down -v --remove-orphans 2>/dev/null || true
        docker compose up -d postgres
        echo "Waiting for PostgreSQL to be ready..."
        until docker exec "$CONTAINER_NAME" pg_isready -U "$DB_USER" > /dev/null 2>&1; do
            sleep 1
        done
        # Additional wait to ensure database is fully initialized
        sleep 2
        # Verify we can actually connect and run queries
        until docker exec "$CONTAINER_NAME" psql -U "$DB_USER" -d "$DB_NAME" -c "SELECT 1" > /dev/null 2>&1; do
            sleep 1
        done
    fi
fi
echo -e "${GREEN}PASS:${NC} Database connection successful"
echo ""

# ============================================
# STEP 2: Check for required files
# ============================================
echo "----------------------------------------"
echo "Step 2: Checking for required files..."
echo "----------------------------------------"

FILES_MISSING=0
for i in 1 2 3 4 5; do
    exercise_file="$SQL_DIR/exercise_0${i}.sql"
    if [ -f "$exercise_file" ]; then
        echo -e "${GREEN}FOUND${NC}: exercise_0${i}.sql"
    else
        echo -e "${YELLOW}MISSING${NC}: exercise_0${i}.sql"
        FILES_MISSING=$((FILES_MISSING + 1))
    fi
done
echo ""

if [ $FILES_MISSING -eq 5 ]; then
    echo -e "${RED}ERROR: No exercise files found in $SQL_DIR${NC}"
    echo "Create your solution files and try again."
    exit 1
fi

# ============================================
# STEP 3: Verifying exercises
# ============================================
echo "----------------------------------------"
echo "Step 3: Verifying exercises..."
echo "----------------------------------------"

# Exercise 1: Basic Filtering (5 queries)
verify_exercise 1 "Basic Filtering" $POINTS_EX1 5

# Exercise 2: Pattern Matching & NULLs (5 queries)
verify_exercise 2 "Pattern Matching & NULLs" $POINTS_EX2 5

# Exercise 3: CASE Expressions & Dates (5 queries)
verify_exercise 3 "CASE Expressions & Dates" $POINTS_EX3 5

# Exercise 4: Basic Aggregation (5 queries)
verify_exercise 4 "Basic Aggregation" $POINTS_EX4 5

# Exercise 5: Grouping & HAVING (5 queries)
verify_exercise 5 "Grouping & HAVING" $POINTS_EX5 5

echo ""

# ============================================
# FINAL SCORE
# ============================================
echo "========================================"
echo "           FINAL SCORE"
echo "========================================"
echo ""
echo -e "Total Points: ${GREEN}$TOTAL_POINTS${NC} / $MAX_POINTS"
echo ""

# Grade calculation
if [ $TOTAL_POINTS -ge 90 ]; then
    echo -e "Grade: ${GREEN}A${NC}"
elif [ $TOTAL_POINTS -ge 80 ]; then
    echo -e "Grade: ${GREEN}B${NC}"
elif [ $TOTAL_POINTS -ge 70 ]; then
    echo -e "Grade: ${YELLOW}C${NC}"
elif [ $TOTAL_POINTS -ge 60 ]; then
    echo -e "Grade: ${YELLOW}D${NC}"
else
    echo -e "Grade: ${RED}F${NC}"
fi

echo ""
echo "========================================"

# Cleanup output directory
rm -rf "$OUTPUT_DIR"
