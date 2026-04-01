# 📺 TV Shows - 剧集记录

> 记录看过的和计划看的电视剧/网剧

## 📊 统计概览

### 追剧统计
```dataview
TABLE length(rows) as "数量"
FROM "60-Entertainment/TV-Shows"
WHERE file.name != "README"
GROUP BY 状态
SORT 状态 DESC
```

### 按地区统计
```dataview
TABLE length(rows) as "数量"
FROM "60-Entertainment/TV-Shows"
WHERE file.name != "README"
GROUP BY 地区
```

---

## 🌟 高分推荐（4星+）

```dataview
TABLE WITHOUT ID
  file.link as "剧集",
  评分 as "评分",
  地区 as "地区",
  年份 as "年份"
FROM "60-Entertainment/TV-Shows"
WHERE 评分 >= 4 AND file.name != "README"
SORT 评分 DESC
```

---

## 📝 正在追剧

```dataview
TABLE WITHOUT ID
  file.link as "剧集",
  进度 as "进度",
  状态 as "状态"
FROM "60-Entertainment/TV-Shows"
WHERE contains(tags, "#在看")
SORT file.mtime DESC
```

---

## 📚 想看清单

```dataview
TABLE WITHOUT ID
  file.link as "剧集",
  类型 as "类型",
  豆瓣评分 as "豆瓣"
FROM "60-Entertainment/TV-Shows"
WHERE contains(tags, "#想看")
SORT file.ctime DESC
```

---

## 📝 已完成

```dataview
TABLE WITHOUT ID
  file.link as "剧集",
  评分 as "评分",
  完成日期 as "完成"
FROM "60-Entertainment/TV-Shows"
WHERE contains(tags, "#看过")
SORT 完成日期 DESC
LIMIT 20
```

---

## 🎬 按地区分类

### 美剧
```dataview
LIST
FROM "60-Entertainment/TV-Shows"
WHERE contains(tags, "#美剧") AND file.name != "README"
SORT 评分 DESC
```

### 英剧
```dataview
LIST
FROM "60-Entertainment/TV-Shows"
WHERE contains(tags, "#英剧") AND file.name != "README"
SORT 评分 DESC
```

### 日剧
```dataview
LIST
FROM "60-Entertainment/TV-Shows"
WHERE contains(tags, "#日剧") AND file.name != "README"
SORT 评分 DESC
```

### 韩剧
```dataview
LIST
FROM "60-Entertainment/TV-Shows"
WHERE contains(tags, "#韩剧") AND file.name != "README"
SORT 评分 DESC
```

### 国产剧
```dataview
LIST
FROM "60-Entertainment/TV-Shows"
WHERE contains(tags, "#国产剧") AND file.name != "README"
SORT 评分 DESC
```

---

## 🎭 按类型分类

### 科幻
```dataview
LIST
FROM "60-Entertainment/TV-Shows"
WHERE contains(tags, "#科幻") AND file.name != "README"
SORT 评分 DESC
```

### 犯罪/悬疑
```dataview
LIST
FROM "60-Entertainment/TV-Shows"
WHERE (contains(tags, "#犯罪") OR contains(tags, "#悬疑")) AND file.name != "README"
SORT 评分 DESC
```

### 喜剧
```dataview
LIST
FROM "60-Entertainment/TV-Shows"
WHERE contains(tags, "#喜剧") AND file.name != "README"
SORT 评分 DESC
```

---

## 💡 追剧笔记索引

### 神剧推荐
- 待补充

### 系列剧集
- 待补充

### 主题推荐
- 待补充

---

[[60-Entertainment/README|← 返回 Entertainment]]
