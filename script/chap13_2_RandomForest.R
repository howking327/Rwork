# chap13_2_RandomForest

# 패키지 설치
install.packages("randomForest")
library(randomForest)

names(iris)

##############################
# 분류트리(y변수 : 범주형)
##############################

# 1. model 생성
model <- randomForest(Species ~ ., data = iris) 
# 500개의 dataset -> tree랜덤 생성 -> 예측치
model
# Number of trees : 500 -> 트리 수
# No. of variables tried at each split: 2 -> 노드 분류에 사용된 변수의 수
# OOB estimate of  error rate: 4% -> 분류정확도 : 96%
# Confusion matrix:
#            setosa versicolor virginica class.error
# setosa         50          0         0        0.00
# versicolor      0         47         3        0.06
# virginica       0          3        47        0.06

(50 + 47 + 47) / 150 # 0.96

model2 <- randomForest(Species ~ ., data = iris, ntree = 400, mtry = 2, importance = T, na.action = na.omit)
model2

importance(model2)
# MeanDecreaseGini : 노드 불순도(불확실성) 개선에 기여하는 변수 - 지니계수

varImpPlot(model2)

##############################
# 회귀트리(y변수 : 연속형)
##############################

library(MASS)
data("Boston")

str(Boston)
# y = medv
# x = 13개 칼럼

p = 14
(1/3) * p # 4.666667

mtry = floor((1/3) * p) # floor : 소수점 이하 절삭
mtry

model3 <- randomForest(medv ~ ., data = Boston, ntree = 500, mtry = mtry, importance = T, na.action = na.omit)
model3
# MSE -> Mean of squared residuals: 9.696567

# 중요변수 시각화
varImpPlot(model3)


# git 확인





