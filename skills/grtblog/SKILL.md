---
name: grtblog
description: Manage GrtBlog v2 blog system via API. Create, update, delete articles, moments, pages, and manage content. Use when you need to automate blog publishing or manage GrtBlog content.
metadata:
  {
    "openclaw":
      {
        "emoji": "📝",
        "requires": { "bins": ["curl", "jq"] },
        "install": [
          {
            "id": "jq",
            "kind": "apt",
            "package": "jq",
            "bins": ["jq"],
            "label": "Install jq for JSON processing"
          }
        ],
        "config": {
          "GRTBLOG_API_URL": {
            "description": "GrtBlog API base URL",
            "default": "https://www.kifroom.icu/api/v2",
            "required": true
          },
          "GRTBLOG_API_TOKEN": {
            "description": "GrtBlog admin API token",
            "required": true,
            "secret": true
          }
        }
      },
  }
---

# GrtBlog Skill

Manage your GrtBlog v2 blog system through its REST API.

## Configuration

Set environment variables or configure in OpenClaw:

```bash
export GRTBLOG_API_URL="https://www.kifroom.icu/api/v2"
export GRTBLOG_API_TOKEN="gt_your_token_here"
```

Or use OpenClaw config:

```json
{
  "skills": {
    "grtblog": {
      "GRTBLOG_API_URL": "https://www.kifroom.icu/api/v2",
      "GRTBLOG_API_TOKEN": "gt_your_token_here"
    }
  }
}
```

## Quick Start

### Test connection
```bash
curl -s -H "Authorization: Bearer $GRTBLOG_API_TOKEN" \
  "$GRTBLOG_API_URL/admin/stats/dashboard" | jq '.data.overview'
```

### Create an article
```bash
curl -X POST \
  -H "Authorization: Bearer $GRTBLOG_API_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "My New Article",
    "content": "# Hello World\n\nThis is my first article.",
    "categoryId": 1,
    "tags": ["test", "hello"],
    "isPublished": true
  }' \
  "$GRTBLOG_API_URL/articles"
```

## API Reference

### Content Management

#### Articles
- List articles: `GET /admin/articles`
- Get article: `GET /admin/articles/{id}`
- Create article: `POST /articles`
- Update article: `PUT /articles/{id}`
- Delete article: `DELETE /articles/{id}`

#### Moments (手记)
- List moments: `GET /admin/moments`
- Create moment: `POST /moments`

#### Pages
- List pages: `GET /admin/pages`
- Create page: `POST /pages`

#### Thinkings (思考)
- List thinkings: `GET /admin/thinkings`
- Create thinking: `POST /thinkings`

### System Management

#### Statistics
- Dashboard stats: `GET /admin/stats/dashboard`

#### Users
- List users: `GET /admin/users`

#### Categories & Tags
- List categories: `GET /admin/categories`
- List tags: `GET /admin/tags`

## Usage Examples

### 1. Publish Markdown content
```bash
# Convert markdown to JSON and publish
title="My Article"
content=$(cat article.md)
category_id=1
tags='["technology", "tutorial"]'

curl -X POST \
  -H "Authorization: Bearer $GRTBLOG_API_TOKEN" \
  -H "Content-Type: application/json" \
  -d "{
    \"title\": \"$title\",
    \"content\": \"$content\",
    \"categoryId\": $category_id,
    \"tags\": $tags,
    \"isPublished\": true
  }" \
  "$GRTBLOG_API_URL/articles"
```

### 2. Get blog statistics
```bash
curl -s -H "Authorization: Bearer $GRTBLOG_API_TOKEN" \
  "$GRTBLOG_API_URL/admin/stats/dashboard" | jq '.data.overview'
```

### 3. List recent articles
```bash
curl -s -H "Authorization: Bearer $GRTBLOG_API_TOKEN" \
  "$GRTBLOG_API_URL/admin/articles?size=5" | jq '.data.items[] | {id, title, views}'
```

### 4. Create a moment (手记)
```bash
curl -X POST \
  -H "Authorization: Bearer $GRTBLOG_API_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Today's thought",
    "content": "Just had a great idea!",
    "isPublished": true
  }' \
  "$GRTBLOG_API_URL/moments"
```

## Integration with Obsidian

### Automate publishing from Obsidian
1. Write content in Obsidian (Markdown)
2. Use frontmatter for metadata:
```yaml
---
title: "Article Title"
category: "technology"
tags: ["web", "javascript"]
published: true
---
```

3. Script to publish:
```bash
#!/bin/bash
# publish-from-obsidian.sh

ARTICLE_FILE="$1"
API_URL="${GRTBLOG_API_URL:-https://www.kifroom.icu/api/v2}"
TOKEN="${GRTBLOG_API_TOKEN}"

# Extract frontmatter and content
title=$(grep -m1 '^title:' "$ARTICLE_FILE" | cut -d'"' -f2)
category=$(grep -m1 '^category:' "$ARTICLE_FILE" | cut -d'"' -f2)
tags=$(grep -m1 '^tags:' "$ARTICLE_FILE" | sed 's/^tags: //')
content=$(sed '1,/^---$/d' "$ARTICLE_FILE")

# Map category name to ID (you'll need to adjust this)
case "$category" in
  "technology") category_id=1 ;;
  *) category_id=1 ;;
esac

# Publish
curl -X POST \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d "{
    \"title\": \"$title\",
    \"content\": \"$content\",
    \"categoryId\": $category_id,
    \"tags\": $tags,
    \"isPublished\": true
  }" \
  "$API_URL/articles"
```

## Response Format

All API responses follow this format:
```json
{
  "code": 0,
  "bizErr": "OK",
  "msg": "success",
  "data": {...},
  "meta": {
    "requestId": "uuid",
    "timestamp": "ISO8601"
  }
}
```

## Error Codes

- `0`: Success
- `400`: Bad Request
- `401`: Unauthorized
- `403`: Forbidden
- `404`: Not Found
- `405`: Method Not Allowed
- `500`: Internal Server Error

## Security Notes

1. **Token Security**: API tokens have full admin access. Store securely.
2. **Rate Limiting**: Be mindful of API rate limits.
3. **Validation**: Always validate input data before sending.
4. **Error Handling**: Implement proper error handling in scripts.

## Troubleshooting

### Common Issues

1. **401 Unauthorized**: Check API token is valid and not expired.
2. **404 Not Found**: Verify API endpoint URL is correct.
3. **400 Bad Request**: Check request body format and required fields.

### Debugging
```bash
# Verbose curl for debugging
curl -v -H "Authorization: Bearer $GRTBLOG_API_TOKEN" \
  "$GRTBLOG_API_URL/admin/stats/dashboard"
```

## Related Resources

- [GrtBlog GitHub](https://github.com/grtsinry43/grtblog)
- [GrtBlog Documentation](https://github.com/grtsinry43/grtblog/tree/main/docs)
- [OpenClaw Skills Documentation](https://docs.openclaw.ai/skills/)

---

*Skill created: 2026-04-01*