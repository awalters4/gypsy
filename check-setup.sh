#!/bin/bash

echo "🔮 Gypsy Setup Diagnostic Tool"
echo "=============================="
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Track if everything is OK
ALL_OK=true

# Check Node.js
echo "1. Checking Node.js..."
if command -v node &> /dev/null; then
    NODE_VERSION=$(node --version)
    echo -e "   ${GREEN}✓${NC} Node.js installed: $NODE_VERSION"
else
    echo -e "   ${RED}✗${NC} Node.js not found"
    ALL_OK=false
fi

# Check npm
echo "2. Checking npm..."
if command -v npm &> /dev/null; then
    NPM_VERSION=$(npm --version)
    echo -e "   ${GREEN}✓${NC} npm installed: $NPM_VERSION"
else
    echo -e "   ${RED}✗${NC} npm not found"
    ALL_OK=false
fi

# Check backend dependencies
echo "3. Checking backend dependencies..."
if [ -d "backend/node_modules" ]; then
    echo -e "   ${GREEN}✓${NC} Backend dependencies installed"
else
    echo -e "   ${RED}✗${NC} Backend dependencies NOT installed"
    echo "      Run: cd backend && npm install"
    ALL_OK=false
fi

# Check frontend dependencies
echo "4. Checking frontend dependencies..."
if [ -d "frontend/node_modules" ]; then
    echo -e "   ${GREEN}✓${NC} Frontend dependencies installed"
else
    echo -e "   ${RED}✗${NC} Frontend dependencies NOT installed"
    echo "      Run: cd frontend && npm install"
    ALL_OK=false
fi

# Check backend .env
echo "5. Checking backend .env..."
if [ -f "backend/.env" ]; then
    echo -e "   ${GREEN}✓${NC} backend/.env exists"

    # Check DATABASE_URL
    if grep -q "DATABASE_URL=postgresql://" backend/.env && ! grep -q "DATABASE_URL=postgresql://user:password@localhost" backend/.env; then
        echo -e "   ${GREEN}✓${NC} DATABASE_URL appears configured"
    else
        echo -e "   ${YELLOW}⚠${NC} DATABASE_URL needs to be configured"
        echo "      Current value appears to be a placeholder"
        ALL_OK=false
    fi

    # Check ANTHROPIC_API_KEY
    if grep -q "ANTHROPIC_API_KEY=" backend/.env && ! grep -q "ANTHROPIC_API_KEY=your_anthropic_api_key_here" backend/.env && ! grep -q "ANTHROPIC_API_KEY=$" backend/.env; then
        echo -e "   ${GREEN}✓${NC} ANTHROPIC_API_KEY appears configured"
    else
        echo -e "   ${YELLOW}⚠${NC} ANTHROPIC_API_KEY needs to be configured"
        echo "      Get your key from: https://console.anthropic.com/"
        ALL_OK=false
    fi
else
    echo -e "   ${RED}✗${NC} backend/.env NOT found"
    echo "      Copy backend/.env.example to backend/.env and configure it"
    ALL_OK=false
fi

# Check frontend .env
echo "6. Checking frontend .env..."
if [ -f "frontend/.env" ]; then
    echo -e "   ${GREEN}✓${NC} frontend/.env exists"

    if grep -q "VITE_API_URL=" frontend/.env; then
        API_URL=$(grep "VITE_API_URL=" frontend/.env | cut -d '=' -f2-)
        echo -e "   ${GREEN}✓${NC} VITE_API_URL configured: $API_URL"
    else
        echo -e "   ${YELLOW}⚠${NC} VITE_API_URL not configured"
        ALL_OK=false
    fi
else
    echo -e "   ${RED}✗${NC} frontend/.env NOT found"
    echo "      Copy frontend/.env.example to frontend/.env"
    ALL_OK=false
fi

# Check if backend can connect to database
echo "7. Checking database connection..."
if [ -f "backend/.env" ]; then
    # Try to load DATABASE_URL
    source backend/.env 2>/dev/null
    if [ ! -z "$DATABASE_URL" ] && [ "$DATABASE_URL" != "postgresql://user:password@localhost:5432/tarot_reader" ]; then
        if command -v psql &> /dev/null; then
            if psql "$DATABASE_URL" -c "SELECT 1" &> /dev/null; then
                echo -e "   ${GREEN}✓${NC} Database connection successful"

                # Check if tables exist
                TABLE_COUNT=$(psql "$DATABASE_URL" -t -c "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema = 'public'" 2>/dev/null | xargs)
                if [ "$TABLE_COUNT" -gt "0" ]; then
                    echo -e "   ${GREEN}✓${NC} Database has $TABLE_COUNT tables"

                    # Check for required tables
                    DECKS=$(psql "$DATABASE_URL" -t -c "SELECT COUNT(*) FROM decks" 2>/dev/null | xargs)
                    SPREADS=$(psql "$DATABASE_URL" -t -c "SELECT COUNT(*) FROM spread_types" 2>/dev/null | xargs)

                    if [ ! -z "$DECKS" ] && [ "$DECKS" -gt "0" ]; then
                        echo -e "   ${GREEN}✓${NC} Found $DECKS decks in database"
                    else
                        echo -e "   ${YELLOW}⚠${NC} No decks found - run migration SQL"
                        echo "      Run: backend/src/database/COMBINED_MIGRATION.sql"
                        ALL_OK=false
                    fi

                    if [ ! -z "$SPREADS" ] && [ "$SPREADS" -gt "0" ]; then
                        echo -e "   ${GREEN}✓${NC} Found $SPREADS spread types in database"
                    else
                        echo -e "   ${YELLOW}⚠${NC} No spread types found - run migration SQL"
                        ALL_OK=false
                    fi
                else
                    echo -e "   ${YELLOW}⚠${NC} Database is empty - run migration SQL"
                    echo "      Run: backend/src/database/COMBINED_MIGRATION.sql"
                    ALL_OK=false
                fi
            else
                echo -e "   ${RED}✗${NC} Cannot connect to database"
                echo "      Check your DATABASE_URL in backend/.env"
                ALL_OK=false
            fi
        else
            echo -e "   ${YELLOW}⚠${NC} psql not installed - cannot verify database"
            echo "      Install PostgreSQL client or check database manually"
        fi
    else
        echo -e "   ${YELLOW}⚠${NC} DATABASE_URL not configured"
        ALL_OK=false
    fi
else
    echo -e "   ${RED}✗${NC} Cannot check - backend/.env missing"
    ALL_OK=false
fi

echo ""
echo "=============================="
if [ "$ALL_OK" = true ]; then
    echo -e "${GREEN}✓ All checks passed!${NC}"
    echo "You should be able to run:"
    echo "  - cd backend && npm run dev"
    echo "  - cd frontend && npm run dev"
else
    echo -e "${YELLOW}⚠ Some issues found${NC}"
    echo "Please review the messages above and fix the issues."
    echo "See SETUP.md for detailed setup instructions."
fi
echo "=============================="
