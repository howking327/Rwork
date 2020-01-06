# chap12_1_LinearRegration

########################
# 1. 단순선형회귀분석
########################
# - 독립변수(1) -> 종속변수(1) 에 미치는 영향 분석

# 데이터셋 가져오기
setwd("c:/Rwork/data")
product <- read.csv("product.csv")
str(product)
# 'data.frame':	264 obs. of  3 variables:
# $ 제품_친밀도: int  3 3 4 2 2 3 4 2 3 4 ...
# $ 제품_적절성: int  4 3 4 2 2 3 4 2 2 2 ...
# $ 제품_만족도: int  3 2 4 2 2 3 4 2 3 3 ...

# 1) x, y변수 선택
x <- product$"제품_적절성" #독립변수
y <- product$"제품_만족도" #종속변수

df <- data.frame(x, y)
df

# 2) 회귀모델 생성
model <- lm(y ~ x, data = df)
model
# Coefficients(회귀계수-기울기,절편):
# (Intercept)             x  
# 0.7789(절편)       0.7393(기울기)  

# 회귀방정식(y) = 0.7393 * x + 0.7789
head(df)
# x = 4, y = 3
x = 4; Y = 3
y = 0.7393 * x + 0.7789 # 예측치
y # 3.7361

# 관측치(정답) - 예측치 = 오차
err <- Y - y
err # -0.7361
abs(err) # 절댓값 취하기
mse = mean(err^2) # 평균제곱오차
mse # 0.5418432 / 제곱을 취하는건 부호를 양수로 변환하고 오차값이 작으면 작게 크면 크게 만들어준다(패널티)

names(model)
# "coefficients" : 계수
# "residuals" : 오차(잔차)
# "fitted.values" : 적합치(예측치)
model$coefficients
model$residuals[1]
model$fitted.values[1]

# 3) 회귀모델 분석
summary(model)
# <회귀모델 분석 순서>
# 1. F-검정 통계량 : 모델의 유의성 검정 (p-value < 0.05)
# F-statistic:   374 on 1 and 262 DF,  p-value: < 2.2e-16

# 2. 모델의 설명력 : Adjusted R-squared 0.5865 (1에 가까울수록 설명력이 높다, 즉 예측력이 높다는 뜻)
# R-squared = R^2
R <- sqrt(0.5865)
R # 0.7658329

# 3. x변수 유의성 검정 : t-value / pr(>|t|) 의 값 비교 (0.05와 비교)에 따라 영향력을 판단(*의 개수로 표현된다)
# Coefficients:
#             Estimate Std. Error  t value Pr(>|t|)    
# (Intercept)  0.77886    0.12416   6.273 1.45e-09 ***
# x            0.73928    0.03823  19.340  < 2e-16 ***
# ---
# Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

# 4) 회귀선 : 회귀방정식에 의해서 구해진 직선식(예측치)
# - 시각화
# x, y산점도
plot(df$x, df$y)
# 회귀선 추가
abline(model, col="red")

########################
# 2. 다중선형회귀분석
########################
# - 독립변수(n) -> 종속변수(1) 미치는 영향 분석

# 데이터셋 가져오기
install.packages("car")
library(car)

Prestige
str(Prestige)
# 'data.frame':	102 obs. of  6 variables:
# $ education(교육수준): num  13.1 12.3 12.8 11.4 14.6 ...
# $ income   (수입): int  12351 25879 9271 8865 8403 11030 8258 14163 11377 11023 ...
# $ women    (여성비율): num  11.16 4.02 15.7 9.11 11.68 ...
# $ prestige (평판): num  68.8 69.1 63.4 56.8 73.5 77.6 72.6 78.1 73.1 68.8 ...
# $ census   (직원수): int  1113 1130 1171 1175 2111 2113 2133 2141 2143 2153 ...
# $ type     (유형): Factor w/ 3 levels "bc","prof","wc": 2 2 2 2 2 2 2 2 2 2 ...
row.names(Prestige) # 102개의 직업군
# 직원수 , 유형은 데이터로서 의미가 없다.
# subset
newdata <- Prestige[c(1:4)]
str(newdata)

# 상관분석
cor(newdata)
#            education(x1)    income  women(x2)   prestige(x3)
# education    1.00000000  0.5775802  0.06185286  0.8501769
# income(y)    0.57758023  1.0000000 -0.44105927  0.7149057

model <- lm(income ~ education + women + prestige, data = newdata)
model
# Coefficients:
# (Intercept)    education        women     prestige  
#     -253.8        177.2        -50.9        141.4  
head(newdata)
#                     education income women prestige
# gov.administrators  13.11     12351  11.16 68.8
income <- 12351
education <- 13.11
women <- 11.16
prestige <- 68.8

# 예측치 : 회귀방정식
y_pred <- 177.2*education + -50.9*women + 141.4*prestige + (-253.8)
y_pred #11229.57

err <- income - y_pred
err # 1121.432

# 회귀모델 분석
summary(model)
# 모델 유의성 검정 : p-value: < 2.2e-16 
# 모델 설명력 : Adjusted R-squared:  0.6323 
# x 유의성 검정 :
# (Intercept) -253.850   1086.157  -0.234    0.816    
# education    177.199    187.632   0.944    0.347 (영향없음)   
# women        -50.896      8.556  -5.948 4.19e-08 ***
# prestige     141.435     29.910   4.729 7.58e-06 ***

########################
# 3. 변수 선택법
########################
# - 최적 모델을 위한 x변수 선택

newdata2 <- Prestige[c(1:5)]
dim(newdata2) # 102   5

library(MASS)
model2 <- lm(income ~ ., data = newdata2)
step <- stepAIC(model2, direction = "both")
step

model3 <- lm(formula = income ~ women + prestige, data = newdata2)
summary(model3)
# F-statistic: p-value: < 2.2e-16
# R-squared:  0.6327 
# women     -5.953 4.02e-08 ***
# prestige   11.067  < 2e-16 ***

# 3가지 변수를 적용한 model과 영향없는 변수를 제거한 model3의 설명력 차이
# 0.6323 / 0.6327 

########################
# 4. 기계학습
########################

iris_data <- iris[-5]
str(iris_data)

# 1) train / test set (70:30)
idx <- sample(x = nrow(iris_data), size = nrow(iris_data)*0.7 , replace = F)
idx

train <- iris_data[idx, ]
test <- iris_data[-idx, ]

dim(train) #105   4
dim(test) #45  4

# 2) model(train)
model <- lm(Sepal.Length ~ ., data = train)

# 3) model 평가(test)
y_pred <- predict(model, test) # y의 예측치
y_pred
y_ture <- test$Sepal.Length # y의 정답

# 평가 : mse(평균제곱오차)
mse <- mean((y_ture - y_pred)^2)
mse # 0.08322443

cor(y_ture, y_pred) # 0.9278513

# y real value / y prediction
plot(y_ture, col = "blue", type = "o", pch = 18)
points(y_pred, col = "red", type = "o", pch = 19)
title("real value vs prediction")
# 범례
legend("topleft", legend = c("real","pred"), col = c("blue", "red"), pch = c(18,19))


##########################################
#  5. 선형회귀분석 잔차검정과 모형진단
##########################################

# 1. 변수 모델링  
# 2. 회귀모델 생성 
# 3. 모형의 잔차검정 
#   1) 잔차의 등분산성 검정
#   2) 잔차의 정규성 검정 
#   3) 잔차의 독립성(자기상관) 검정 
# 4. 다중공선성 검사 
# 5. 회귀모델 생성/ 평가 


names(iris)

# 1. 변수 모델링 : y:Sepal.Length <- x:Sepal.Width,Petal.Length,Petal.Width
formula = Sepal.Length ~ Sepal.Width + Petal.Length + Petal.Width


# 2. 회귀모델 생성 
model <- lm(formula = formula,  data=iris)
model
names(model)


# 3. 모형의 잔차검정
plot(model)
#Hit <Return> to see next plot: 잔차 vs 적합값 -> 패턴없이 무작위 분포(포물선 분포 좋지않은 적합) 
#Hit <Return> to see next plot: Normal Q-Q -> 정규분포 : 대각선이면 잔차의 정규성 
#Hit <Return> to see next plot: 척도 vs 위치 -> 중심을 기준으로 고루 분포 
#Hit <Return> to see next plot: 잔차 vs 지렛대값 -> 중심을 기준으로 고루 분포 

# (1) 등분산성 검정 
plot(model, which =  1) 
methods('plot') # plot()에서 제공되는 객체 보기 

# (2) 잔차 정규성 검정
attributes(model) # coefficients(계수), residuals(잔차), fitted.values(적합값)
res <- residuals(model) # 잔차 추출 
res <- model$residuals # ↑ 결과동일

shapiro.test(res) # 정규성 검정 - p-value = 0.9349 >= 0.05
# 귀무가설 : 정규성과 차이가 없다.

# 정규성 시각화  
hist(res, freq = F) 
qqnorm(res)

# (3) 잔차의 독립성(자기상관 검정 : Durbin-Watson) 
install.packages('lmtest')
library(lmtest) # 자기상관 진단 패키지 설치 
dwtest(model) # 더빈 왓슨 값


# 4. 다중공선성 검사 
# - 독립변수간의 강한 상관관계로 인해서 발생하는 문제
# - ex) 생년월일, 생일
library(car)
sqrt(vif(model)) > 2 # TRUE 

# 5. 모델 생성/평가 
formula = Sepal.Length ~ Sepal.Width + Petal.Length
cor(iris[-5])
model <- lm(formula = formula,  data=iris)
summary(model) # 모델 평가
























