#!/usr/bin/env bash
# =============================================================================
# Assignment 01 - Setup Verification Script
# =============================================================================
# This script verifies student submissions for the introductory assignment
# Usage: ./verify.sh
# =============================================================================

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Score tracking
TOTAL_POINTS=0
MAX_POINTS=100

# Points per image
POINTS_PER_IMAGE=20

# Get script directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Required images
REQUIRED_IMAGES=(
    "repo_name.png"
    "actions_enabled.png"
    "collaborators.png"
    "ai_disabled.png"
    "adminer_connection.png"
)

echo "========================================"
echo "  Assignment 01 - Setup Verification"
echo "========================================"
echo ""

echo "----------------------------------------"
echo "Checking for required screenshots..."
echo "----------------------------------------"

for image in "${REQUIRED_IMAGES[@]}"; do
    if [ -f "$SCRIPT_DIR/$image" ]; then
        echo -e "${GREEN}PASS:${NC} Found: $image (+$POINTS_PER_IMAGE pts)"
        TOTAL_POINTS=$((TOTAL_POINTS + POINTS_PER_IMAGE))
    else
        echo -e "${RED}FAIL:${NC} Missing: $image (0/$POINTS_PER_IMAGE pts)"
    fi
done

echo ""
echo "========================================"
echo "           FINAL SCORE"
echo "========================================"
echo ""
echo "Total Points: $TOTAL_POINTS / $MAX_POINTS"
echo ""

# Assign grade
if [ $TOTAL_POINTS -ge 90 ]; then
    echo "Grade: A"
elif [ $TOTAL_POINTS -ge 80 ]; then
    echo "Grade: B"
elif [ $TOTAL_POINTS -ge 70 ]; then
    echo "Grade: C"
elif [ $TOTAL_POINTS -ge 60 ]; then
    echo "Grade: D"
else
    echo "Grade: F"
fi

echo ""
echo "========================================"

# Exit with success (don't fail the pipeline)
exit 0
