---
title: "Getting Started with GrtBlog API"
category: "technology"
tags: ["api", "blogging", "automation"]
published: true
summary: "Learn how to automate your blog publishing with GrtBlog API"
---

# Getting Started with GrtBlog API

GrtBlog provides a powerful REST API that allows you to automate your blog publishing workflow. In this article, we'll explore how to use the API to manage your content programmatically.

## API Basics

### Authentication
All API requests require an authentication token in the header:

```bash
Authorization: Bearer gt_your_token_here
```

### Base URL
The API is available at:
```
https://your-domain.com/api/v2
```

## Common Operations

### 1. Creating Articles
To create a new article, send a POST request to `/articles`:

```json
{
  "title": "Article Title",
  "content": "# Markdown content here...",
  "categoryId": 1,
  "tags": ["tag1", "tag2"],
  "isPublished": true
}
```

### 2. Managing Content
- List articles: `GET /admin/articles`
- Update article: `PUT /articles/{id}`
- Delete article: `DELETE /articles/{id}`

### 3. Getting Statistics
View your blog analytics: `GET /admin/stats/dashboard`

## Automation Workflow

Here's a typical automation workflow:

1. **Write content** in your favorite editor (Obsidian, VS Code, etc.)
2. **Format with frontmatter** for metadata
3. **Use scripts** to publish automatically
4. **Monitor results** through the API

## Example Script

```bash
#!/bin/bash
# publish.sh

API_URL="https://your-domain.com/api/v2"
API_TOKEN="gt_your_token"

curl -X POST \
  -H "Authorization: Bearer $API_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Automated Post",
    "content": "# Hello from automation!",
    "categoryId": 1,
    "tags": ["automation", "api"],
    "isPublished": true
  }' \
  "$API_URL/articles"
```

## Benefits of Automation

1. **Consistency** - Maintain a regular publishing schedule
2. **Efficiency** - Reduce manual work
3. **Integration** - Connect with other tools and workflows
4. **Scalability** - Manage large volumes of content easily

## Next Steps

1. Explore the full API documentation
2. Set up automated publishing from your note-taking app
3. Create monitoring dashboards for your blog analytics
4. Integrate with CI/CD pipelines for technical content

---

*Happy automating!*