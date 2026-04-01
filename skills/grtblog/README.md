# GrtBlog Skill for OpenClaw

A skill for managing GrtBlog v2 blog system through its REST API.

## Features

- 📝 **Create and manage articles**
- 📊 **View blog statistics and analytics**
- 🔄 **Automate publishing workflows**
- 🏷️ **Manage categories and tags**
- 📱 **Support for moments, pages, and thinkings**

## Installation

### 1. Install dependencies
```bash
# Install jq for JSON processing
sudo apt-get install jq  # Debian/Ubuntu
# or
brew install jq          # macOS
```

### 2. Configure environment variables
```bash
export GRTBLOG_API_URL="https://www.kifroom.icu/api/v2"
export GRTBLOG_API_TOKEN="gt_your_token_here"
```

### 3. Or configure in OpenClaw
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
./scripts/quick-test.sh
```

### Publish an article
```bash
./scripts/publish-article.sh publish examples/sample-article.md
```

### Dry run (test without publishing)
```bash
./scripts/publish-article.sh dry-run examples/sample-article.md
```

### List articles
```bash
./scripts/publish-article.sh list
```

### Get statistics
```bash
./scripts/publish-article.sh stats
```

## File Structure

```
grtblog/
├── SKILL.md              # Skill metadata and documentation
├── README.md             # This file
├── scripts/
│   ├── publish-article.sh # Main publishing script
│   └── quick-test.sh     # API connection test
└── examples/
    └── sample-article.md # Example markdown file
```

## Markdown Format

Articles should follow this format:

```markdown
---
title: "Article Title"
category: "technology"
tags: ["tag1", "tag2"]
published: true
summary: "Optional summary"
---

# Article Content

Your markdown content here...
```

## API Endpoints

### Content Management
- `POST /articles` - Create article
- `GET /admin/articles` - List articles
- `PUT /articles/{id}` - Update article
- `DELETE /articles/{id}` - Delete article

### Statistics
- `GET /admin/stats/dashboard` - Blog statistics

### System Management
- `GET /admin/users` - List users
- `GET /admin/categories` - List categories
- `GET /admin/tags` - List tags

## Integration with Obsidian

This skill works well with Obsidian notes:

1. Write content in Obsidian with frontmatter
2. Use the publish script to automate posting
3. Keep your Obsidian vault as the source of truth

Example workflow:
```bash
# From your Obsidian vault directory
find . -name "*.md" -newer .last-publish | \
  xargs -I {} ../skills/grtblog/scripts/publish-article.sh publish {}
```

## Security Notes

1. **API tokens have full admin access** - Store them securely
2. **Use environment variables** for sensitive data
3. **Implement error handling** in your scripts
4. **Monitor API usage** to avoid rate limits

## Troubleshooting

### Common Issues

1. **401 Unauthorized**: Check your API token
2. **404 Not Found**: Verify API URL is correct
3. **400 Bad Request**: Check request format and required fields

### Debugging
```bash
# Enable verbose output
curl -v -H "Authorization: Bearer $GRTBLOG_API_TOKEN" \
  "$GRTBLOG_API_URL/admin/stats/dashboard"
```

## Related Resources

- [GrtBlog GitHub Repository](https://github.com/grtsinry43/grtblog)
- [OpenClaw Skills Documentation](https://docs.openclaw.ai/skills/)
- [Markdown Guide](https://www.markdownguide.org/)

## License

This skill is provided as-is. See the main OpenClaw documentation for license information.

---

*Skill created: 2026-04-01*  
*Last updated: 2026-04-01*