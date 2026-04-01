# 🎥 Movies - 电影记录

> 记录看过的和计划看的电影

## 📊 统计概览

### 观影统计
```dataview
TABLE length(rows) as "数量"
FROM "60-Entertainment/Movies"
WHERE file.name != "README"
GROUP BY 状态
SORT 状态 DESC
```

### 按年份统计
```dataview
TABLE length(rows) as "观看数量"
FROM "60-Entertainment/Movies"
WHERE 观看日期 AND file.name != "README"
GROUP BY dateformat(观看日期, "yyyy") as "年份"
SORT 年份 DESC
```

---

## 🌟 高分推荐（4星+）

```dataview
TABLE WITHOUT ID
  file.link as "电影",
  评分 as "评分",
  类型 as "类型",
  年份 as "年份"
FROM "60-Entertainment/Movies"
WHERE 评分 >= 4 AND file.name != "README"
SORT 评分 DESC, 观看日期 DESC
```

---

## 📝 最近观看

```dataview
TABLE WITHOUT ID
  file.link as "电影",
  评分 as "评分",
  观看日期 as "日期"
FROM "60-Entertainment/Movies"
WHERE 观看日期 AND file.name != "README"
SORT 观看日期 DESC
LIMIT 10
```

---

## 📚 想看清单

```dataview
TABLE WITHOUT ID
  file.link as "电影",
  类型 as "类型",
  豆瓣评分 as "豆瓣"
FROM "60-Entertainment/Movies"
WHERE contains(tags, "#想看")
SORT file.ctime DESC
```

---

## 🎬 按类型分类

### 科幻
```dataview
LIST
FROM "60-Entertainment/Movies"
WHERE contains(tags, "#科幻") AND file.name != "README"
SORT 评分 DESC
```

### 剧情
```dataview
LIST
FROM "60-Entertainment/Movies"
WHERE contains(tags, "#剧情") AND file.name != "README"
SORT 评分 DESC
```

### 动作
```dataview
LIST
FROM "60-Entertainment/Movies"
WHERE contains(tags, "#动作") AND file.name != "README"
SORT 评分 DESC
```

### 喜剧
```dataview
LIST
FROM "60-Entertainment/Movies"
WHERE contains(tags, "#喜剧") AND file.name != "README"
SORT 评分 DESC
```

---

## 💡 观影笔记索引

### 经典必看
- 待补充

### 导演专题
- 待补充

### 主题推荐
- 待补充

---

[[60-Entertainment/README|← 返回 Entertainment]]
