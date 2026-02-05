#!/usr/bin/env bash
set -e
# =============================================================================
# MedCare Health Clinic - Assignment 05 Verification Script
# =============================================================================
# This script verifies student SQL Join solutions
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
echo "  MedCare Clinic Assignment 5 - Verification"
echo "========================================"
echo ""

# Create output directory
mkdir -p "$OUTPUT_DIR"

# Function to run SQL and capture result
run_sql() {
    if [ "$RUN_MODE" = "container" ]; then
        psql -h "$DB_HOST" -U "$DB_USER" -d "$DB_NAME" -t -c "$1" 2>&1
    else
        docker exec "$CONTAINER_NAME" psql -U "$DB_USER" -d "$DB_NAME" -t -c "$1" 2>&1
    fi
}

# Function to run SQL file
run_sql_file() {
    local sql_file="$1"
    local output_file="$2"
    if [ "$RUN_MODE" = "container" ]; then
        psql -h "$DB_HOST" -U "$DB_USER" -d "$DB_NAME" < "$sql_file" > "$output_file" 2>&1
    else
        docker exec -i "$CONTAINER_NAME" psql -U "$DB_USER" -d "$DB_NAME" < "$sql_file" > "$output_file" 2>&1
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

# Compare outputs (ignoring whitespace differences)
compare_outputs() {
    local student_output="$1"
    local solution_output="$2"
    
    # Normalize whitespace and compare
    diff -wB <(cat "$student_output" | sed 's/[[:space:]]*$//' | grep -v '^$') \
             <(cat "$solution_output" | sed 's/[[:space:]]*$//' | grep -v '^$') > /dev/null 2>&1
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
for file in 01-inner-joins 02-left-joins 03-right-full-joins 04-self-joins 05-multi-table-joins; do
    if [ -f "$SQL_DIR/$file.sql" ]; then
        echo -e "${GREEN}PASS:${NC} Found: $file.sql"
    else
        echo -e "${YELLOW}⚠${NC} Missing: $file.sql"
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

# Exercise 1: Inner Joins
exercise_file="$SQL_DIR/01-inner-joins.sql"
solution_file="$SOLUTIONS_DIR/01-inner-joins.sql"
if [ -f "$exercise_file" ]; then
    student_output="$OUTPUT_DIR/student_ex1.txt"
    solution_output="$OUTPUT_DIR/solution_ex1.txt"
    
    if run_sql_file "$exercise_file" "$student_output" 2>/dev/null; then
        run_sql_file "$solution_file" "$solution_output" 2>/dev/null
        if compare_outputs "$student_output" "$solution_output"; then
            print_result "Exercise 1: Inner Joins" true $POINTS_EX1
        else
            print_result "Exercise 1: Inner Joins" false $POINTS_EX1
        fi
    else
        echo -e "${RED}FAIL${NC}: Exercise 1 - SQL syntax error (0/$POINTS_EX1 pts)"
    fi
else
    echo -e "${YELLOW}⚠ SKIP${NC}: Exercise 1 - File not found (0/$POINTS_EX1 pts)"
fi

# Exercise 2: Left Joins
exercise_file="$SQL_DIR/02-left-joins.sql"
solution_file="$SOLUTIONS_DIR/02-left-joins.sql"
if [ -f "$exercise_file" ]; then
    student_output="$OUTPUT_DIR/student_ex2.txt"
    solution_output="$OUTPUT_DIR/solution_ex2.txt"
    
    if run_sql_file "$exercise_file" "$student_output" 2>/dev/null; then
        run_sql_file "$solution_file" "$solution_output" 2>/dev/null
        if compare_outputs "$student_output" "$solution_output"; then
            print_result "Exercise 2: Left Joins" true $POINTS_EX2
        else
            print_result "Exercise 2: Left Joins" false $POINTS_EX2
        fi
    else
        echo -e "${RED}FAIL${NC}: Exercise 2 - SQL syntax error (0/$POINTS_EX2 pts)"
    fi
else
    echo -e "${YELLOW}⚠ SKIP${NC}: Exercise 2 - File not found (0/$POINTS_EX2 pts)"
fi

# Exercise 3: Right & Full Joins
exercise_file="$SQL_DIR/03-right-full-joins.sql"
solution_file="$SOLUTIONS_DIR/03-right-full-joins.sql"
if [ -f "$exercise_file" ]; then
    student_output="$OUTPUT_DIR/student_ex3.txt"
    solution_output="$OUTPUT_DIR/solution_ex3.txt"
    
    if run_sql_file "$exercise_file" "$student_output" 2>/dev/null; then
        run_sql_file "$solution_file" "$solution_output" 2>/dev/null
        if compare_outputs "$student_output" "$solution_output"; then
            print_result "Exercise 3: Right & Full Joins" true $POINTS_EX3
        else
            print_result "Exercise 3: Right & Full Joins" false $POINTS_EX3
        fi
    else
        echo -e "${RED}FAIL${NC}: Exercise 3 - SQL syntax error (0/$POINTS_EX3 pts)"
    fi
else
    echo -e "${YELLOW}⚠ SKIP${NC}: Exercise 3 - File not found (0/$POINTS_EX3 pts)"
fi

# Exercise 4: Self Joins
exercise_file="$SQL_DIR/04-self-joins.sql"
solution_file="$SOLUTIONS_DIR/04-self-joins.sql"
if [ -f "$exercise_file" ]; then
    student_output="$OUTPUT_DIR/student_ex4.txt"
    solution_output="$OUTPUT_DIR/solution_ex4.txt"
    
    if run_sql_file "$exercise_file" "$student_output" 2>/dev/null; then
        run_sql_file "$solution_file" "$solution_output" 2>/dev/null
        if compare_outputs "$student_output" "$solution_output"; then
            print_result "Exercise 4: Self Joins" true $POINTS_EX4
        else
            print_result "Exercise 4: Self Joins" false $POINTS_EX4
        fi
    else
        echo -e "${RED}FAIL${NC}: Exercise 4 - SQL syntax error (0/$POINTS_EX4 pts)"
    fi
else
    echo -e "${YELLOW}⚠ SKIP${NC}: Exercise 4 - File not found (0/$POINTS_EX4 pts)"
fi

# Exercise 5: Multi-Table Joins
exercise_file="$SQL_DIR/05-multi-table-joins.sql"
solution_file="$SOLUTIONS_DIR/05-multi-table-joins.sql"
if [ -f "$exercise_file" ]; then
    student_output="$OUTPUT_DIR/student_ex5.txt"
    solution_output="$OUTPUT_DIR/solution_ex5.txt"
    
    if run_sql_file "$exercise_file" "$student_output" 2>/dev/null; then
        run_sql_file "$solution_file" "$solution_output" 2>/dev/null
        if compare_outputs "$student_output" "$solution_output"; then
            print_result "Exercise 5: Multi-Table Joins" true $POINTS_EX5
        else
            print_result "Exercise 5: Multi-Table Joins" false $POINTS_EX5
        fi
    else
        echo -e "${RED}FAIL${NC}: Exercise 5 - SQL syntax error (0/$POINTS_EX5 pts)"
    fi
else
    echo -e "${YELLOW}⚠ SKIP${NC}: Exercise 5 - File not found (0/$POINTS_EX5 pts)"
fi
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
