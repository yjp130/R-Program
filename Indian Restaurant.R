install.packages("dplyr")
library(dplyr)
install.packages("ggplot2")
library(ggplot2)
library(stringr)
search()

food<-read.csv("C:/Users/ktm/Desktop/restaurant-1-orders/restaurant-1-orders.csv")
View(food)

table(df$Item.Name)
View(df)
###년, 월, 일로 나누기
df <- food %>% 
  mutate(year = substring(as.character(food$Order.Date), 7,10),
         month = substring(as.character(food$Order.Date), 4,5),
         day=substring(as.character(food$Order.Date),1,2),
         time = substring(as.character(food$Order.Date), 12,13))

###2018년 음식별 주문수
df_food <- df %>%
  filter(year=='2018') %>%
  group_by(Item.Name) %>%
  summarise(q=sum(Quantity))

### 2015년, 2019년 제외
df_food <- df %>%
  filter(year=='2018') %>%

### Top 10 음식
df_food<-df_food%>% arrange(desc(q))
df_food
df_food[1:10]

ggplot(data=df_food[1:10,], aes(x=reorder(Item.Name,-q), y= q))+geom_col()

### 머신러닝

set.seed(0)
idx <- sample(1:nrow(df),
              size=nrow(df)*0.9,
              replace=F)
idx

tr <- df[idx, ]
test<-df[-idx,]

colnames(tr)

#모델 생성
lm.Model<-lm(medv~. , data=Boston_tr)
summary(lm.Model)

#모델 예측
pred_value<-predict(lm.Model, Boston_test)
pred_value[0:10]

