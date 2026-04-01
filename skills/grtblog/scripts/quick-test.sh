#!/bin/bash
# quick-test.sh - Quick test of GrtBlog API connection

set -e

API_URL="${GRTBLOG_API_URL:-https://www.kifroom.icu/api/v2}"
API_TOKEN="${GRTBLOG_API_TOKEN}"

# Check if token is set
if [ -z "$API_TOKEN" ]; then
    echo "❌ GRTBLOG_API_TOKEN is not set"
    echo "Set it with: export GRTBLOG_API_TOKEN='your_token_here'"
    exit 1
fi

echo "🔍 Testing GrtBlog API connection..."
echo "API URL: $API_URL"
echo "Token: ${API_TOKEN:0:10}..."

# Test connection
echo -e "\n📊 Testing /admin/stats/dashboard..."
response=$(curl -s -w "\n%{http_code}" \
    -H "Authorization: Bearer $API_TOKEN" \
    "$API_URL/admin/stats/dashboard")

http_code=$(echo "$response" | tail -n1)
response_body=$(echo "$response" | sed '$d')

if [ "$http_code" = "200" ]; then
    echo "✅ Connection successful! (HTTP $http_code)"
    
    if command -v jq &> /dev/null; then
        echo -e "\n📈 Blog Statistics:"
        echo "$response_body" | jq -r '
            .data.overview | 
            "Articles: \(.articlesTotal) (\(.articlesPublished) published, \(.articlesDraft) draft)
Moments: \(.momentsTotal) (\(.momentsPublished) published, \(.momentsDraft) draft)
Pages: \(.pagesTotal) (\(.pagesEnabled) enabled)
Users: \(.users)
Total words: \(.words.total)"
        '
    else
        echo "Response: $response_body"
    fi
else
    echo "❌ Connection failed (HTTP $http_code)"
    echo "Response: $response_body"
    exit 1
fi

# Test articles endpoint
echo -e "\n📝 Testing /admin/articles..."
response=$(curl -s -w "\n%{http_code}" \
    -H "Authorization: Bearer $API_TOKEN" \
    "$API_URL/admin/articles?size=3")

http_code=$(echo "$response" | tail -n1)
response_body=$(echo "$response" | sed '$d')

if [ "$http_code" = "200" ]; then
    echo "✅ Articles endpoint accessible"
    
    if command -v jq &> /dev/null; then
        echo -e "\n📰 Recent Articles:"
        echo "$response_body" | jq -r '.data.items[] | "• \(.title) (ID: \(.id), Views: \(.views))"'
    fi
else
    echo "⚠️  Articles endpoint failed (HTTP $http_code)"
fi

echo -e "\n🎉 GrtBlog API test completed successfully!"