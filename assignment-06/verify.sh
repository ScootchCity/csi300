#!/usr/bin/env bash
set -e
# =============================================================================
# PawCare Veterinary - Assignment 06 Verification Script
# =============================================================================
# Verifies student SQL solutions (subqueries, CTEs, views)
# Usage:
#   - Local: docker-compose run --rm verify
#   - GitHub Actions: bash ./verify.sh
# =============================================================================

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

CONTAINER_NAME="${CONTAINER_NAME:-postgres}"
DB_USER="${PGUSER:-postgres}"
DB_NAME="${PGDATABASE:-postgres}"

if [ -n "$PGHOST" ]; then
    RUN_MODE="container"
    DB_HOST="$PGHOST"
    SQL_DIR="/sql"
else
    RUN_MODE="host"
    SQL_DIR="./sql"
fi

OUTPUT_DIR="/tmp/output"
TOTAL_POINTS=0
MAX_POINTS=100

echo "========================================"
echo "  PawCare Vet Assignment 6 - Verification"
echo "========================================"
echo ""

mkdir -p "$OUTPUT_DIR"

run_sql() {
    if [ "$RUN_MODE" = "container" ]; then
        psql -h "$DB_HOST" -U "$DB_USER" -d "$DB_NAME" -t -c "$1" 2>/dev/null | grep -v '^$' | head -1 | tr -d ' '
    else
        docker exec "$CONTAINER_NAME" psql -U "$DB_USER" -d "$DB_NAME" -t -c "$1" 2>/dev/null | grep -v '^$' | head -1 | tr -d ' '
    fi
}

run_sql_file() {
    local sql_file="$1"
    local output_file="$2"
    if [ "$RUN_MODE" = "container" ]; then
        psql -h "$DB_HOST" -U "$DB_USER" -d "$DB_NAME" -f "$sql_file" > "$output_file" 2>&1
    else
        docker exec -i "$CONTAINER_NAME" psql -U "$DB_USER" -d "$DB_NAME" < "$sql_file" > "$output_file" 2>&1
    fi
}

print_result() {
    _test_name=$1
    _passed=$2
    _points=$3
    if [ "$_passed" = "true" ]; then
        echo -e "${GREEN}PASS${NC}: $_test_name (+$_points pts)"
        TOTAL_POINTS=$((TOTAL_POINTS + _points))
    else
        echo -e "${RED}FAIL${NC}: $_test_name (0/$_points pts)"
    fi
}

get_row_count() {
    sed -n 's/.*(\([0-9][0-9]*\) rows\{0,1\}).*/\1/p' "$1" | sed -n "${2}p"
}

# ============================================
# STEP 1: Check database connection
# ============================================
echo "----------------------------------------"
echo "Step 1: Checking database connection..."
echo "----------------------------------------"

if [ "$RUN_MODE" = "container" ]; then
    if ! psql -h "$DB_HOST" -U "$DB_USER" -d "$DB_NAME" -c "SELECT 1" > /dev/null 2>&1; then
        echo -e "${RED}Error: Cannot connect to database.${NC}"
        exit 1
    fi
else
    if ! docker ps --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
        echo "Starting PostgreSQL..."
        docker compose down -v --remove-orphans 2>/dev/null || true
        docker compose up -d postgres
        until docker exec "$CONTAINER_NAME" pg_isready -U "$DB_USER" > /dev/null 2>&1; do sleep 1; done
        sleep 2
        until docker exec "$CONTAINER_NAME" psql -U "$DB_USER" -d "$DB_NAME" -c "SELECT 1" > /dev/null 2>&1; do sleep 1; done
    fi
fi
echo -e "${GREEN}PASS:${NC} Database connection successful"

PET_COUNT=$(run_sql "SELECT COUNT(*) FROM pets;")
PET_COUNT=${PET_COUNT:-0}
if [ "$PET_COUNT" -lt 1 ]; then
    echo -e "${RED}Error: PawCare schema not initialized properly.${NC}"
    exit 1
fi
echo -e "${GREEN}PASS:${NC} PawCare schema loaded ($PET_COUNT pets)"
echo ""

# ============================================
# STEP 2: Check for required files
# ============================================
echo "----------------------------------------"
echo "Step 2: Checking for required files..."
echo "----------------------------------------"

FILES_MISSING=0
for file in exercise01 exercise02 exercise03 exercise04 exercise05; do
    if [ -f "$SQL_DIR/$file.sql" ]; then
        echo -e "${GREEN}FOUND${NC}: $file.sql"
    else
        echo -e "${YELLOW}MISSING${NC}: $file.sql"
        FILES_MISSING=$((FILES_MISSING + 1))
    fi
done
echo ""

if [ $FILES_MISSING -eq 5 ]; then
    echo -e "${RED}ERROR: No exercise files found.${NC}"
    exit 1
fi

# Pre-compute expected values
PETS_WITH_WEIGHT=$(run_sql "SELECT COUNT(*) FROM pets WHERE weight_kg IS NOT NULL;")
ALL_PETS=$(run_sql "SELECT COUNT(*) FROM pets;")
ALL_STAFF=$(run_sql "SELECT COUNT(*) FROM staff;")
ALL_CLINICS=$(run_sql "SELECT COUNT(*) FROM clinics;")
ALL_OWNERS=$(run_sql "SELECT COUNT(*) FROM owners;")

# ============================================
# STEP 3: Exercise 1 - Scalar Subqueries (20 pts)
# ============================================
echo "----------------------------------------"
echo "Step 3: Exercise 1 - Subqueries Basics (20 pts)"
echo "----------------------------------------"

EX_FILE="$SQL_DIR/exercise01.sql"
EX_OUT="$OUTPUT_DIR/ex1.txt"
if [ -f "$EX_FILE" ]; then
    run_sql_file "$EX_FILE" "$EX_OUT" 2>/dev/null || true

    if ! grep -qE "^ERROR:.*(syntax|does not exist|permission|column)" "$EX_OUT" 2>/dev/null; then
        print_result "No SQL errors" "true" 4
    else
        print_result "No SQL errors" "false" 4
    fi

    QC=$(grep -c "rows\{0,1\})" "$EX_OUT" 2>/dev/null) || QC=0
    if [ "$QC" -ge 5 ]; then
        print_result "All 5 queries present" "true" 4
    else
        print_result "All 5 queries present ($QC found)" "false" 4
    fi

    R1=$(get_row_count "$EX_OUT" 1)
    if [ "${R1:-0}" = "$PETS_WITH_WEIGHT" ]; then
        print_result "1.1 Pets with weight comparison ($R1 rows)" "true" 4
    else
        print_result "1.1 Pets with weight comparison (got ${R1:-0}, expected $PETS_WITH_WEIGHT)" "false" 4
    fi

    R2=$(get_row_count "$EX_OUT" 2)
    R3=$(get_row_count "$EX_OUT" 3)
    NON_EMPTY=0
    [ -n "$R2" ] && [ "$R2" -gt 0 ] 2>/dev/null && NON_EMPTY=$((NON_EMPTY + 1))
    [ -n "$R3" ] && [ "$R3" -gt 0 ] 2>/dev/null && NON_EMPTY=$((NON_EMPTY + 1))
    if [ "$NON_EMPTY" -eq 2 ]; then
        print_result "1.2, 1.3 return data" "true" 4
    else
        print_result "1.2, 1.3 return data ($NON_EMPTY/2)" "false" 4
    fi

    R4=$(get_row_count "$EX_OUT" 4)
    R5=$(get_row_count "$EX_OUT" 5)
    NON_EMPTY=0
    [ -n "$R4" ] && [ "$R4" -gt 0 ] 2>/dev/null && NON_EMPTY=$((NON_EMPTY + 1))
    [ -n "$R5" ] && [ "$R5" -gt 0 ] 2>/dev/null && NON_EMPTY=$((NON_EMPTY + 1))
    if [ "$NON_EMPTY" -eq 2 ]; then
        print_result "1.4, 1.5 return data" "true" 4
    else
        print_result "1.4, 1.5 return data ($NON_EMPTY/2)" "false" 4
    fi
else
    echo -e "${YELLOW}SKIP${NC}: Exercise 1 - File not found (0/20 pts)"
fi
echo ""

# ============================================
# STEP 4: Exercise 2 - Correlated Subqueries (20 pts)
# ============================================
echo "----------------------------------------"
echo "Step 4: Exercise 2 - Correlated Subqueries (20 pts)"
echo "----------------------------------------"

EX_FILE="$SQL_DIR/exercise02.sql"
EX_OUT="$OUTPUT_DIR/ex2.txt"
if [ -f "$EX_FILE" ]; then
    run_sql_file "$EX_FILE" "$EX_OUT" 2>/dev/null || true

    if ! grep -qE "^ERROR:.*(syntax|does not exist|permission|column)" "$EX_OUT" 2>/dev/null; then
        print_result "No SQL errors" "true" 4
    else
        print_result "No SQL errors" "false" 4
    fi

    QC=$(grep -c "rows\{0,1\})" "$EX_OUT" 2>/dev/null) || QC=0
    if [ "$QC" -ge 5 ]; then
        print_result "All 5 queries present" "true" 4
    else
        print_result "All 5 queries present ($QC found)" "false" 4
    fi

    R1=$(get_row_count "$EX_OUT" 1)
    if [ "${R1:-0}" = "$PETS_WITH_WEIGHT" ]; then
        print_result "2.1 Pets above species avg weight ($R1 rows)" "true" 4
    else
        print_result "2.1 Pets above avg (got ${R1:-0}, expected $PETS_WITH_WEIGHT)" "false" 4
    fi

    R2=$(get_row_count "$EX_OUT" 2)
    R3=$(get_row_count "$EX_OUT" 3)
    NON_EMPTY=0
    [ -n "$R2" ] && [ "$R2" -gt 0 ] 2>/dev/null && NON_EMPTY=$((NON_EMPTY + 1))
    [ -n "$R3" ] && [ "$R3" -gt 0 ] 2>/dev/null && NON_EMPTY=$((NON_EMPTY + 1))
    if [ "$NON_EMPTY" -eq 2 ]; then
        print_result "2.2, 2.3 return data" "true" 4
    else
        print_result "2.2, 2.3 return data ($NON_EMPTY/2)" "false" 4
    fi

    R4=$(get_row_count "$EX_OUT" 4)
    R5=$(get_row_count "$EX_OUT" 5)
    NON_EMPTY=0
    [ -n "$R4" ] && [ "$R4" -gt 0 ] 2>/dev/null && NON_EMPTY=$((NON_EMPTY + 1))
    [ -n "$R5" ] && [ "$R5" -gt 0 ] 2>/dev/null && NON_EMPTY=$((NON_EMPTY + 1))
    if [ "$NON_EMPTY" -eq 2 ]; then
        print_result "2.4, 2.5 return data" "true" 4
    else
        print_result "2.4, 2.5 return data ($NON_EMPTY/2)" "false" 4
    fi
else
    echo -e "${YELLOW}SKIP${NC}: Exercise 2 - File not found (0/20 pts)"
fi
echo ""

# ============================================
# STEP 5: Exercise 3 - Common Table Expressions (20 pts)
# ============================================
echo "----------------------------------------"
echo "Step 5: Exercise 3 - Set Operations (20 pts)"
echo "----------------------------------------"

EX_FILE="$SQL_DIR/exercise03.sql"
EX_OUT="$OUTPUT_DIR/ex3.txt"
if [ -f "$EX_FILE" ]; then
    run_sql_file "$EX_FILE" "$EX_OUT" 2>/dev/null || true

    if ! grep -qE "^ERROR:.*(syntax|does not exist|permission|column)" "$EX_OUT" 2>/dev/null; then
        print_result "No SQL errors" "true" 4
    else
        print_result "No SQL errors" "false" 4
    fi

    QC=$(grep -c "rows\{0,1\})" "$EX_OUT" 2>/dev/null) || QC=0
    if [ "$QC" -ge 5 ]; then
        print_result "All 5 queries present" "true" 4
    else
        print_result "All 5 queries present ($QC found)" "false" 4
    fi

    R1=$(get_row_count "$EX_OUT" 1)
    R1=${R1:-0}
    EXPECTED_R1=$((ALL_OWNERS + ALL_STAFF))
    if [ "$R1" -ge "$EXPECTED_R1" ] 2>/dev/null; then
        print_result "3.1 Contact directory ($R1 rows)" "true" 4
    else
        print_result "3.1 Contact directory (got $R1, expected >= $EXPECTED_R1)" "false" 4
    fi

    R3=$(get_row_count "$EX_OUT" 3)
    R4=$(get_row_count "$EX_OUT" 4)
    NON_EMPTY=0
    [ -n "$R3" ] 2>/dev/null && NON_EMPTY=$((NON_EMPTY + 1))
    [ -n "$R4" ] && [ "$R4" -gt 0 ] 2>/dev/null && NON_EMPTY=$((NON_EMPTY + 1))
    if [ "$NON_EMPTY" -eq 2 ]; then
        print_result "3.3 EXCEPT result ($R3 rows), 3.4 returns data ($R4 rows)" "true" 4
    else
        print_result "3.3, 3.4 return results ($NON_EMPTY/2)" "false" 4
    fi

    R5=$(get_row_count "$EX_OUT" 5)
    if [ -n "$R5" ] && [ "$R5" -gt 0 ] 2>/dev/null; then
        print_result "3.5 Clinic revenue ranking ($R5 rows)" "true" 4
    else
        print_result "3.5 Clinic revenue ranking (empty result)" "false" 4
    fi
else
    echo -e "${YELLOW}SKIP${NC}: Exercise 3 - File not found (0/20 pts)"
fi
echo ""

# ============================================
# STEP 6: Exercise 4 - Advanced CTEs (20 pts)
# ============================================
echo "----------------------------------------"
echo "Step 6: Exercise 4 - CTEs (20 pts)"
echo "----------------------------------------"

EX_FILE="$SQL_DIR/exercise04.sql"
EX_OUT="$OUTPUT_DIR/ex4.txt"
if [ -f "$EX_FILE" ]; then
    run_sql_file "$EX_FILE" "$EX_OUT" 2>/dev/null || true

    if ! grep -qE "^ERROR:.*(syntax|does not exist|permission|column)" "$EX_OUT" 2>/dev/null; then
        print_result "No SQL errors" "true" 4
    else
        print_result "No SQL errors" "false" 4
    fi

    QC=$(grep -c "rows\{0,1\})" "$EX_OUT" 2>/dev/null) || QC=0
    if [ "$QC" -ge 5 ]; then
        print_result "All 5 queries present" "true" 4
    else
        print_result "All 5 queries present ($QC found)" "false" 4
    fi

    R2=$(get_row_count "$EX_OUT" 2)
    if [ "${R2:-0}" = "$ALL_PETS" ]; then
        print_result "4.2 Pet health vs species avg ($R2 rows)" "true" 4
    else
        print_result "4.2 Pet health (got ${R2:-0}, expected $ALL_PETS)" "false" 4
    fi

    R3=$(get_row_count "$EX_OUT" 3)
    if [ "${R3:-0}" = "$ALL_STAFF" ]; then
        print_result "4.3 Staff rankings ($R3 rows)" "true" 4
    else
        print_result "4.3 Staff rankings (got ${R3:-0}, expected $ALL_STAFF)" "false" 4
    fi

    R5=$(get_row_count "$EX_OUT" 5)
    R5=${R5:-0}
    if [ "$R5" -gt 0 ] && [ "$R5" -le "$ALL_CLINICS" ] 2>/dev/null; then
        print_result "4.5 Clinic performance tiers ($R5 rows)" "true" 4
    else
        print_result "4.5 Clinic tiers (got $R5, expected 1-$ALL_CLINICS)" "false" 4
    fi
else
    echo -e "${YELLOW}SKIP${NC}: Exercise 4 - File not found (0/20 pts)"
fi
echo ""

# ============================================
# STEP 7: Exercise 5 - Views (20 pts)
# ============================================
echo "----------------------------------------"
echo "Step 7: Exercise 5 - Views (20 pts)"
echo "----------------------------------------"

EX_FILE="$SQL_DIR/exercise05.sql"
EX_OUT="$OUTPUT_DIR/ex5.txt"
if [ -f "$EX_FILE" ]; then
    run_sql_file "$EX_FILE" "$EX_OUT" 2>/dev/null || true

    if ! grep -qE "^ERROR:.*(syntax|does not exist|permission|column)" "$EX_OUT" 2>/dev/null; then
        print_result "No SQL errors" "true" 4
    else
        print_result "No SQL errors" "false" 4
    fi

    # Check for v_pet_directory view
    VIEW1=$(run_sql "SELECT COUNT(*) FROM information_schema.views WHERE table_name = 'v_pet_directory';")
    if [ "${VIEW1:-0}" = "1" ]; then
        print_result "v_pet_directory view exists" "true" 4
    else
        print_result "v_pet_directory view exists" "false" 4
    fi

    # Check for v_staff_directory view
    VIEW2=$(run_sql "SELECT COUNT(*) FROM information_schema.views WHERE table_name = 'v_staff_directory';")
    if [ "${VIEW2:-0}" = "1" ]; then
        print_result "v_staff_directory view exists" "true" 4
    else
        print_result "v_staff_directory view exists" "false" 4
    fi

    # Check for v_active_appointments view
    VIEW3=$(run_sql "SELECT COUNT(*) FROM information_schema.views WHERE table_name = 'v_active_appointments';")
    if [ "${VIEW3:-0}" = "1" ]; then
        print_result "v_active_appointments view exists" "true" 4
    else
        print_result "v_active_appointments view exists" "false" 4
    fi

    # Check for mv_clinic_performance materialized view
    MATVIEW=$(run_sql "SELECT COUNT(*) FROM pg_matviews WHERE matviewname = 'mv_clinic_performance';")
    if [ "${MATVIEW:-0}" = "1" ]; then
        print_result "mv_clinic_performance materialized view exists" "true" 4
    else
        print_result "mv_clinic_performance materialized view exists" "false" 4
    fi
else
    echo -e "${YELLOW}SKIP${NC}: Exercise 5 - File not found (0/20 pts)"
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

rm -rf "$OUTPUT_DIR"
