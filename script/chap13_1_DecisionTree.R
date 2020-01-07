# chap13_1_DecisionTree

# 관련 패키지 설치
install.packages("rpart")
library(rpart)

# tree 시각화 패키지
install.packages("rpart.plot")
library(rpart.plot)

# 1. dataset(train/test) : iris
idx <- sample(nrow(iris), nrow(iris)*0.7)
train <- iris[idx, ]
test <- iris[-idx, ]
names(iris)

# 2. 분류모델
model <- rpart(Species ~ ., data = train)
model
# 분류모델 시각화
rpart.plot(model)
# [중요변수] 가장 주요변수 : "Petal.Length"

# 3. 분류모델 평가
y_pred <- predict(model, test) # 비율 예측치
y_pred <- predict(model, test, type = "class")
y_pred

y_true <- test$Species # 정답
# 교차분할표
table(y_true, y_pred)

acc <- (16+12+14) / nrow(test)
acc # 0.93333333

#######################
# titanic 분류분석
#######################
setwd("c:/Rwork/data")
titanic3 <- read.csv("titanic3.csv")
str(titanic3)

# int -> Factor(범주형) 형변환
titanic3$survived <- factor(titanic3$survived, levels = c(0,1))
table(titanic3$survived)
# 0   1 
# 809 500 

809 / 1309 # 0.618029(62%)

# subset 생성 : 칼럼 제외
titanic <- titanic3[-c(3,8,10,12:14)]
str(titanic)
# 'data.frame':	1309 obs. of  8 variables:
# $ survived: Factor w/ 2 levels 

# train / test set
idx <- sample(nrow(titanic), nrow(titanic)*0.8)
train <- titanic[idx, ]
test <- titanic[-idx, ]

model <- rpart(survived ~ ., data = train)
rpart.plot(model)

y_pred <- predict(model, test, type = "class")
y_true <- test$survived

table(y_true, y_pred)

acc <- (143+65) / nrow(test)
acc # 0.7938931

table(test$survived)
# 0   1
# 162 100

# 정확률
precision <- 65 / 84 #  0.7738095
# 재현률
recall <- 65 / 100 # 0.65
# f1 score
f1_score = 2 * ((precision * recall) / (precision + recall))
# 0.7065217























