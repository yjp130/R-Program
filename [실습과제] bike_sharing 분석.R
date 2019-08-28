library(dplyr)
library(ggplot2)

search()

bike <- read.csv("C:/Users/ktm/Desktop/bike-sharing-demand/train.csv")

head(bike)
View(bike)
dim(bike)
str(bike)
summary(bike)



##1. 계절에 따른 시간당 자전거 대여 횟수
#표
season_cnt <- bike %>%
  group_by(season) %>%
  summarise(mean_casual = mean(casual),
            mean_registered = mean(registered),
            mean_count = mean(count)) %>%
  mutate(per_casual = round(mean_casual/mean_count*100,1))

season_cnt

#그래프
ggplot(data = season_cnt, aes(x=season, y=mean_count)) + geom_col()


#2. 시간에 따른 자전거 대여 횟수
#표
bike$new_datetime <- strptime(bike$datetime,"%Y-%m-%d %H:%M:%S")
bike$time <- as.numeric(format(bike$new_datetime, "%H"))
bike$time

time_cnt <- bike %>%
  group_by(time) %>%
  summarise(mean_casual = mean(casual),
            mean_registered = mean(registered),
            mean_count = mean(count))

time_cnt

qplot(data=bike, x=bike$season)

#그래프
ggplot(data=time_cnt, aes(x=time, y=mean_count)) + geom_line()


#3. 날씨 및 휴일에 따른 시간당 대여 횟수
#표
bike$holiday <- ifelse(bike$holiday == 0, "workingday", "holiday")
table(bike$holiday)

weather_cnt <- bike %>%
  group_by(weather, holiday) %>%
  summarise(mean_casual = mean(casual),
            mean_registered = mean(registered),
            mean_count = mean(count))

weather_cnt

#그래프


ggplot(data=weather_cnt, aes(x=weather, y=mean_count, fill=holiday)) + geom_col(position = "dodge")
ggplot(data=bike, aes(x=weather, y=count, fill=holiday)) + geom_col(position = "dodge")

qplot(bike$holiday)

#4. 날씨 및 근무일일에 따른 시간당 대여 횟수
#표
bike$workingday <- ifelse(bike$working == 0, "notworking", "working")
table(bike$workingday, bike$holiday)

weather_work_cnt <- bike %>%
  group_by(weather, workingday) %>%
  summarise(mean_casual = mean(casual),
            mean_registered = mean(registered),
            mean_count = mean(count))

weather_work_cnt

#그래프
ggplot(data=weather_work_cnt, aes(x=weather, y=mean_count, fill=workingday)) + geom_col(position = "dodge")

#5. 온도, 습도에 따른 시간당 대여 횟수
install.packages("gridExtra")
library(gridExtra)
search()

a=ggplot(data=season_cnt, aes(x=temp, y=mean_count)) + geom_col()
b=ggplot(data=bike, aes(x=atemp, y=count)) + geom_col()
b

c=ggplot(data=bike, aes(x=humidity , y=count)) + geom_col()
c

d=ggplot(data=bike, aes(x=windspeed , y=count)) + geom_col() 
d

grid.arrange(a,b,c,d,ncol=2,nrow=2)

boxplot(bike$temp, bike$atemp, bike$humidity, bike$windspeed,
        main="Stats Analysis in terms of Weather conditions",
        at=c(1,2,3,4),
        names=c("temp","atemp","humidity","windspeed"),
        las=1,
        col=c("yellow","orange","red","blue"),
        border="brown",
        horizontal=TRUE,
        notch=TRUE)
#등록자의 총합, 비등록자의 총합 대여 총합

