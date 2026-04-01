#!/bin/bash
# publish-article.sh - Publish Markdown content to GrtBlog

set -e

# Configuration
API_URL="${GRTBLOG_API_URL:-https://www.kifroom.icu/api/v2}"
API_TOKEN="${GRTBLOG_API_TOKEN}"
DEFAULT_CATEGORY_ID=1  # Technology category

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Log functions
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check dependencies
check_deps() {
    if ! command -v curl &> /dev/null; then
        log_error "curl is required but not installed"
        exit 1
    fi
    
    if ! command -v jq &> /dev/null; then
        log_warning "jq is not installed. JSON parsing will be limited."
    fi
}

# Check configuration
check_config() {
    if [ -z "$API_TOKEN" ]; then
        log_error "GRTBLOG_API_TOKEN is not set"
        log_info "Set it with: export GRTBLOG_API_TOKEN='your_token_here'"
        exit 1
    fi
    
    log_info "API URL: $API_URL"
    log_info "Using token: ${API_TOKEN:0:10}..."
}

# Extract frontmatter from markdown file
extract_frontmatter() {
    local file="$1"
    local key="$2"
    
    if [ ! -f "$file" ]; then
        log_error "File not found: $file"
        exit 1
    fi
    
    # Extract value from frontmatter
    grep -m1 "^$key:" "$file" | sed -e "s/^$key: //" -e 's/^"//' -e 's/"$//' -e "s/^'//" -e "s/'$//"
}

# Extract content (remove frontmatter)
extract_content() {
    local file="$1"
    
    # Remove frontmatter (lines between --- and ---)
    sed '1,/^---$/d' "$file" | sed '/^---$/,$d'
}

# Parse tags string to JSON array
parse_tags() {
    local tags="$1"
    
    if [ -z "$tags" ]; then
        echo '[]'
        return
    fi
    
    # Convert comma-separated or space-separated to JSON array
    echo "$tags" | sed 's/,/","/g' | sed 's/^/["/' | sed 's/$/"]/'
}

# Map category name to ID
map_category() {
    local category="$1"
    
    case "$(echo "$category" | tr '[:upper:]' '[:lower:]')" in
        "technology"|"tech"|"技术")
            echo 1
            ;;
        # Add more categories as needed
        *)
            echo "$DEFAULT_CATEGORY_ID"
            ;;
    esac
}

# Publish article to GrtBlog
publish_article() {
    local file="$1"
    local dry_run="${2:-false}"
    
    log_info "Processing: $file"
    
    # Extract metadata
    local title=$(extract_frontmatter "$file" "title")
    local category=$(extract_frontmatter "$file" "category")
    local tags=$(extract_frontmatter "$file" "tags")
    local published=$(extract_frontmatter "$file" "published")
    local summary=$(extract_frontmatter "$file" "summary")
    
    # Set defaults
    if [ -z "$title" ]; then
        title=$(basename "$file" .md)
        log_warning "No title found, using filename: $title"
    fi
    
    if [ -z "$category" ]; then
        category="technology"
        log_warning "No category specified, using default: $category"
    fi
    
    if [ -z "$published" ]; then
        published="true"
    fi
    
    # Convert published string to boolean
    if [[ "$published" =~ ^(true|yes|1)$ ]]; then
        published="true"
    else
        published="false"
    fi
    
    # Extract content
    local content=$(extract_content "$file")
    
    # Map category to ID
    local category_id=$(map_category "$category")
    
    # Parse tags
    local tags_json=$(parse_tags "$tags")
    
    # Create JSON payload
    local payload=$(cat <<EOF
{
    "title": "$title",
    "content": "$(echo "$content" | jq -R -s '.')",
    "categoryId": $category_id,
    "tags": $tags_json,
    "isPublished": $published,
    "allowComment": true,
    "isOriginal": true
}
EOF
)
    
    log_info "Title: $title"
    log_info "Category: $category (ID: $category_id)"
    log_info "Tags: $tags_json"
    log_info "Published: $published"
    log_info "Content length: ${#content} characters"
    
    if [ "$dry_run" = "true" ]; then
        log_info "Dry run - would publish with payload:"
        echo "$payload" | jq '.' 2>/dev/null || echo "$payload"
        return 0
    fi
    
    # Make API request
    log_info "Publishing to GrtBlog..."
    
    local response=$(curl -s -w "\n%{http_code}" \
        -X POST \
        -H "Authorization: Bearer $API_TOKEN" \
        -H "Content-Type: application/json" \
        -d "$payload" \
        "$API_URL/articles")
    
    local http_code=$(echo "$response" | tail -n1)
    local response_body=$(echo "$response" | sed '$d')
    
    if [ "$http_code" = "200" ] || [ "$http_code" = "201" ]; then
        if command -v jq &> /dev/null; then
            local article_id=$(echo "$response_body" | jq -r '.data.id // empty')
            local short_url=$(echo "$response_body" | jq -r '.data.shortUrl // empty')
            
            if [ -n "$article_id" ]; then
                log_success "Article published successfully!"
                log_info "Article ID: $article_id"
                log_info "Short URL: $short_url"
                log_info "View at: https://www.kifroom.icu/posts/$short_url"
            else
                log_success "Article published (could not parse response)"
                echo "$response_body" | jq '.'
            fi
        else
            log_success "Article published (HTTP $http_code)"
            echo "$response_body"
        fi
    else
        log_error "Failed to publish article (HTTP $http_code)"
        echo "$response_body"
        return 1
    fi
}

# List articles
list_articles() {
    log_info "Fetching articles..."
    
    local response=$(curl -s \
        -H "Authorization: Bearer $API_TOKEN" \
        "$API_URL/admin/articles?size=10")
    
    if command -v jq &> /dev/null; then
        echo "$response" | jq -r '.data.items[] | "\(.id) | \(.title) | \(.views) views | \(.createdAt)"'
    else
        echo "$response"
    fi
}

# Get statistics
get_stats() {
    log_info "Fetching blog statistics..."
    
    local response=$(curl -s \
        -H "Authorization: Bearer $API_TOKEN" \
        "$API_URL/admin/stats/dashboard")
    
    if command -v jq &> /dev/null; then
        echo "$response" | jq '.data.overview'
    else
        echo "$response"
    fi
}

# Show usage
usage() {
    cat <<EOF
GrtBlog Publisher

Usage: $0 [command] [options]

Commands:
  publish <file.md>     Publish a markdown file to GrtBlog
  dry-run <file.md>     Test publishing without actually posting
  list                  List recent articles
  stats                 Get blog statistics
  help                  Show this help message

Options:
  --api-url <url>       Override API URL (default: $API_URL)
  --token <token>       Override API token

Environment variables:
  GRTBLOG_API_URL       GrtBlog API base URL
  GRTBLOG_API_TOKEN     GrtBlog admin API token (required)

Examples:
  $0 publish my-article.md
  $0 dry-run my-article.md
  $0 list
  $0 stats
  export GRTBLOG_API_TOKEN="gt_your_token"; $0 publish my-article.md

Markdown file format:
  ---
  title: "Article Title"
  category: "technology"
  tags: ["web", "javascript"]
  published: true
  summary: "Optional summary"
  ---
  
  # Article content here...
EOF
}

# Main function
main() {
    check_deps
    
    local command="${1:-help}"
    
    case "$command" in
        publish)
            check_config
            if [ -z "$2" ]; then
                log_error "No file specified"
                usage
                exit 1
            fi
            publish_article "$2" "false"
            ;;
        dry-run|dryrun)
            check_config
            if [ -z "$2" ]; then
                log_error "No file specified"
                usage
                exit 1
            fi
            publish_article "$2" "true"
            ;;
        list)
            check_config
            list_articles
            ;;
        stats)
            check_config
            get_stats
            ;;
        help|--help|-h)
            usage
            ;;
        *)
            log_error "Unknown command: $command"
            usage
            exit 1
            ;;
    esac
}

# Handle command line arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        --api-url)
            API_URL="$2"
            shift 2
            ;;
        --token)
            API_TOKEN="$2"
            shift 2
            ;;
        *)
            break
            ;;
    esac
done

# Run main function
main "$@"