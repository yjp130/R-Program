install.packages("rJava")
install.packages("memoise")
install.packages("KoNLP")

library(rJava)
library(memoise)
library(KoNLP)
search()

useNIADic()
### 데이터 준비하기(스파이더맨 데이터)
txt <- readLines("C:\\dataset\\SpiderMan.txt")
head(txt)

install.packages("stringr")
library(stringr)
library(KoNLP)
txt <- str_replace_all(txt, "\\W", " ")

nouns <- extractNoun(txt)
wordCount <- table(unlist(nouns))
wordCount

##데이터 프레임 변경
df_word <- as.data.frame(wordCount, stringsAsFactors = F)
df_word

library(dplyr)
df_word<- rename(df_word, word=Var1, freq=Freq)
nrow(df_word)

##텍스트 
install.packages("wordcloud")
library(wordcloud)
library(RColorBrewer)

#색상추출
pal <-brewer.pal(8, "Dark2")
set.seed(1004)

#워드 클라우드
wordcloud(word=df_word$word,
          freq=df_word$freq,
          color=pal,
          random.order=F,
          rot.per=0.4,
          max.words=100)

getwd()
