#!/usr/bin/env bash
set -e
# =============================================================================
# EduLearn LMS - Assignment 04 Verification Script
# =============================================================================
# This script verifies student submissions for the normalization assignment
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
DB_SCHEMA="public"

# Detect if running inside container or on host
if [ -n "$PGHOST" ]; then
    RUN_MODE="container"
    DB_HOST="$PGHOST"
    SQL_DIR="/sql"
else
    RUN_MODE="host"
    SQL_DIR="./sql"
fi

# Score tracking
TOTAL_POINTS=0
MAX_POINTS=100

echo "========================================"
echo "  EduLearn LMS Assignment 4 - Verification"
echo "========================================"
echo ""

# Function to run SQL and capture result
run_sql() {
    if [ "$RUN_MODE" = "container" ]; then
        psql -h "$DB_HOST" -U "$DB_USER" -d "$DB_NAME" -v ON_ERROR_STOP=1 -t -c "$1" 2>/dev/null | grep -v '^$' | head -1 | tr -d ' '
    else
        docker exec "$CONTAINER_NAME" psql -U "$DB_USER" -d "$DB_NAME" -v ON_ERROR_STOP=1 -t -c "$1" 2>/dev/null | grep -v '^$' | head -1 | tr -d ' '
    fi
}

# Function to print test result
print_result() {
    _test_name=$1
    _passed=$2
    _points=$3

    if [ "$_passed" = "true" ]; then
        echo "${GREEN}PASS${NC}: $_test_name (+$_points pts)"
        TOTAL_POINTS=$((TOTAL_POINTS + _points))
    else
        echo "${RED}FAIL${NC}: $_test_name (0/$_points pts)"
    fi
}

# ============================================
# STEP 1: Check environment
# ============================================
echo "----------------------------------------"
echo "Step 1: Checking database connection..."
echo "----------------------------------------"

if [ "$RUN_MODE" = "container" ]; then
    if ! psql -h "$DB_HOST" -U "$DB_USER" -d "$DB_NAME" -c "SELECT 1" > /dev/null 2>&1; then
        echo "${RED}Error: Cannot connect to database.${NC}"
        echo "Please make sure the database is running with: docker-compose up -d"
        exit 1
    fi
else
    # Start docker-compose if postgres is not running
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
echo "${GREEN}PASS:${NC} Database connection successful"
echo ""

# ============================================
# STEP 2: Check for required files
# ============================================
echo "----------------------------------------"
echo "Step 2: Checking for required files..."
echo "----------------------------------------"

SCHEMA_FILE="$SQL_DIR/02_schema.sql"
SEED_FILE="$SQL_DIR/03_seed.sql"
INDEXES_FILE="$SQL_DIR/04_indexes.sql"

if [ -f "$SCHEMA_FILE" ]; then
    echo -e "${GREEN}PASS:${NC} Found: 02_schema.sql"
else
    echo -e "${YELLOW}⚠${NC} Missing: 02_schema.sql"
fi

if [ -f "$SEED_FILE" ]; then
    echo -e "${GREEN}PASS:${NC} Found: 03_seed.sql"
else
    echo -e "${YELLOW}⚠${NC} Missing: 03_seed.sql"
fi

if [ -f "$INDEXES_FILE" ]; then
    echo -e "${GREEN}PASS:${NC} Found: 04_indexes.sql"
else
    echo -e "${YELLOW}⚠${NC} Missing: 04_indexes.sql"
fi
echo ""

# ============================================
# STEP 3: Verify Schema (40 points)
# ============================================
echo "----------------------------------------"
echo "Step 3: Verifying schema (40 points)..."
echo "----------------------------------------"

# Check tables exist (20 pts - 2 each)
for table in departments instructors students student_phones courses modules assignments enrollments grades certificates; do
    EXISTS=$(run_sql "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema = '$DB_SCHEMA' AND table_name = '$table';")
    if [ "$EXISTS" = "1" ]; then
        print_result "Table '$table' exists" "true" 2
    else
        print_result "Table '$table' exists" "false" 2
    fi
done

# Check foreign key constraints (10 pts)
FK_COUNT=$(run_sql "SELECT COUNT(*) FROM information_schema.table_constraints WHERE constraint_type = 'FOREIGN KEY' AND table_schema = '$DB_SCHEMA';")
FK_COUNT=${FK_COUNT:-0}
if [ "$FK_COUNT" -ge 8 ]; then
    print_result "Foreign key constraints (found $FK_COUNT, min 8)" "true" 10
else
    print_result "Foreign key constraints (found $FK_COUNT, min 8)" "false" 10
fi

# Check unique constraints (10 pts)
UNIQUE_COUNT=$(run_sql "SELECT COUNT(*) FROM information_schema.table_constraints WHERE constraint_type = 'UNIQUE' AND table_schema = '$DB_SCHEMA';")
UNIQUE_COUNT=${UNIQUE_COUNT:-0}
if [ "$UNIQUE_COUNT" -ge 5 ]; then
    print_result "Unique constraints (found $UNIQUE_COUNT, min 5)" "true" 10
else
    print_result "Unique constraints (found $UNIQUE_COUNT, min 5)" "false" 10
fi
echo ""

# ============================================
# STEP 4: Verify Seed Data (30 points)
# ============================================
echo "----------------------------------------"
echo "Step 4: Verifying seed data (30 points)..."
echo "----------------------------------------"

# Function to check row count
check_count() {
    _table=$1
    _expected=$2
    ACTUAL=$(run_sql "SELECT COUNT(*) FROM $_table;" 2>/dev/null || echo "0")
    ACTUAL=${ACTUAL:-0}
    if [ "$ACTUAL" = "$_expected" ]; then
        print_result "$_table has $ACTUAL rows (expected $_expected)" "true" 3
    else
        print_result "$_table has $ACTUAL rows (expected $_expected)" "false" 3
    fi
}

check_count "departments" 3
check_count "instructors" 4
check_count "students" 8
check_count "student_phones" 12
check_count "courses" 5
check_count "modules" 16
check_count "assignments" 18
check_count "enrollments" 15
check_count "grades" 8
check_count "certificates" 8
echo ""

# ============================================
# STEP 5: Verify Indexes (30 points)
# ============================================
echo "----------------------------------------"
echo "Step 5: Verifying indexes (30 points)..."
echo "----------------------------------------"

# Count custom indexes (20 pts for 10+ indexes)
INDEX_COUNT=$(run_sql "SELECT COUNT(DISTINCT indexname) FROM pg_indexes WHERE schemaname = '$DB_SCHEMA' AND indexname NOT LIKE '%_pkey' AND indexname NOT LIKE '%_key';")
INDEX_COUNT=${INDEX_COUNT:-0}

if [ "$INDEX_COUNT" -ge 10 ]; then
    print_result "Custom indexes created (found $INDEX_COUNT, min 10)" "true" 20
else
    print_result "Custom indexes created (found $INDEX_COUNT, min 10)" "false" 20
fi

# Check for specific important indexes (10 pts)
FOUND_IMPORTANT=0
for idx in idx_enrollments_student idx_enrollments_course idx_modules_course idx_assignments_course; do
    EXISTS=$(run_sql "SELECT COUNT(*) FROM pg_indexes WHERE schemaname = '$DB_SCHEMA' AND indexname = '$idx';")
    if [ "$EXISTS" = "1" ]; then
        FOUND_IMPORTANT=$((FOUND_IMPORTANT + 1))
    fi
done

if [ "$FOUND_IMPORTANT" -ge 4 ]; then
    print_result "Key indexes present ($FOUND_IMPORTANT/4 found)" "true" 10
else
    print_result "Key indexes present ($FOUND_IMPORTANT/4 found)" "false" 10
fi
echo ""

# ============================================
# FINAL SCORE
# ============================================
echo "========================================"
echo "           FINAL SCORE"
echo "========================================"
echo ""
echo "Total Points: ${GREEN}$TOTAL_POINTS${NC} / $MAX_POINTS"
echo ""

# Grade calculation
if [ $TOTAL_POINTS -ge 90 ]; then
    echo "Grade: ${GREEN}A${NC}"
elif [ $TOTAL_POINTS -ge 80 ]; then
    echo "Grade: ${GREEN}B${NC}"
elif [ $TOTAL_POINTS -ge 70 ]; then
    echo "Grade: ${YELLOW}C${NC}"
elif [ $TOTAL_POINTS -ge 60 ]; then
    echo "Grade: ${YELLOW}D${NC}"
else
    echo "Grade: ${RED}F${NC}"
fi

echo ""
echo "========================================"
