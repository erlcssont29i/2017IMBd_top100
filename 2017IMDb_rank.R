webpage <- read_html(url)

# 用CSS选择器获取排名部分
rank_data_html <- html_nodes(webpage,'.text-primary')

# 把排名转换为文本
rank_data <- html_text(rank_data_html)

# 数据预处理：把排名转换为数值型
rank_data<-as.numeric(rank_data)

# 检查一遍
#head(rank_data)

# 爬取标题
title_data_html <- html_nodes(webpage,'.lister-item-header a')

# 转换为文本
title_data <- html_text(title_data_html)

# 检查一下
#head(title_data)

#------------------------
#Step 7: 爬取剩余的数据– Description, Runtime, Genre, Rating, 
#Metascore, Votes, Gross_Earning_in_Mil , Director and Actor data.

# 爬取描述
description_data_html <- html_nodes(webpage,'.ratings-bar+ .text-muted')

# 转为文本
description_data <- html_text(description_data_html)

# 检查一下
#head(description_data)

# 移除 '\n'
description_data<-gsub("\n","",description_data)

# 再检查一下
#head(description_data)

# 爬取runtime section
runtime_data_html <- html_nodes(webpage,'.text-muted .runtime')

# 转为文本
runtime_data <- html_text(runtime_data_html)

# 检查一下
#head(runtime_data)

# 数据预处理: 去除“min”并把数字转换为数值型

runtime_data <- gsub(" min","",runtime_data)
runtime_data <- as.numeric(runtime_data)


# 爬取genre
genre_data_html <- html_nodes(webpage,'.genre')

# 转为文本
genre_data <- html_text(genre_data_html)

# 检查一下
#head(genre_data)


# 去除“\n”
genre_data<-gsub("\n","",genre_data)

# 去除多余空格
genre_data<-gsub(" ","",genre_data)

# 每部电影只保留第一种类型
genre_data<-gsub(",.*","",genre_data)

# 转化为因子
genre_data<-as.factor(genre_data)

# 再检查一下
#head(genre_data)

#----------------------------------------------
#10 Levels: Action Adventure Animation Biography Comedy Crime Drama ... Thriller

# 爬取IMDB rating
rating_data_html <- html_nodes(webpage,'.ratings-imdb-rating strong')

# 转为文本
rating_data <- html_text(rating_data_html)

# 检查一下
#head(rating_data)


# 转为数值型
rating_data<-as.numeric(rating_data)

# 再检查一下
#head(rating_data)

[1] 7.2 7.7 7.6 8.2 7.0 6.5

# 爬取votes section
votes_data_html <- html_nodes(webpage,'.sort-num_votes-visible span:nth-child(2)')

# 转为文本
votes_data <- html_text(votes_data_html)

# 检查一下
#head(votes_data)

# 移除“，”
votes_data<-gsub(",", "", votes_data)

# 转为数值型
votes_data<-as.numeric(votes_data)

# 再检查一下
head(votes_data)


# 爬取directors section
directors_data_html <- html_nodes(webpage,'.text-muted+ p a:nth-child(1)')

# 转为文本
directors_data <- html_text(directors_data_html)

# 检查一下
head(directors_data)len


# 转为因子
directors_data<-as.factor(directors_data)

# 爬取actors section
actors_data_html <- html_nodes(webpage,'.lister-item-content .ghost+ a')

# 转为文本
actors_data <- html_text(actors_data_html)

# 检查一下
#head(actors_data)

# 转为因子
actors_data<-as.factor(actors_data)

#-----数据合并前用length检查各变量长度，发现有些变量只有95个值（遇到缺失值），长度不同无法list，怎么补缺失值呢？-------------
这个问题产生的原型是由5部电影没有ra数据。如果只是简单地用NA来填充这四个缺失值，它会自动填充第97到100部电影。
#通过视觉检查，我们发缺失的是第12，37,49,54和69部电影。我用下面的函数来解决这个问题。


for (i in c(12,37,49,54,69)) {rating_data <- append(rating_data, "NA", (i-1))}
for (i in c(12,37,49,54,69)){description_data <- append(description_data, "NA", (i-1))}
for (i in c(12,37,49,54,69)){votes_data <- append(votes_data, "NA", (i-1))}

#---------directors长度却是101，把因子变成变成矩阵 一样用肉眼检查，多抓了第49列，故删掉第49列，在转换回因子
directors_data<-as.factor(as.matrix(directors_data)[-49,])


# 合并所有list来创建一个数据框
movies_df <- data.frame(
  Rank = rank_data, 
  Title = title_data,
  Description = description_data, 
  Runtime = runtime_data,
  Genre = genre_data, 
  Rating = rating_data, 
  Votes = votes_data,                           
  Director = directors_data, 
  Actor = actors_data
)
