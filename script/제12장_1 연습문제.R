#################################
## <제12장 연습문제>
################################# 

# 01. mpg의 엔진크기(displ)가 고속도록주행마일(hwy)에 어떤 영향을 미치는가?    
# <조건1> 단순선형회귀모델 생성 
library(ggplot2)
data(mpg)
str(mpg)

x <- mpg$displ
y <- mpg$hwy

df <- data.frame(x, y)
df
model <- lm(y ~ x , data = df)
model
# 회귀방정식(y) = -3.531 * x + 35.698
head(df)
x = 1.8; Y = 29
y = -3.531 * x + 35.698
y # 29.3422

# <조건2> 회귀선 시각화 
plot(df$x , df$y)
# text 추가
text(df$x, df$y, labels = df$y, cex = 0.7, pos = 3, col = "blue")
abline(model, col="red")

# <조건3> 회귀분석 결과 해석 : 모델 유의성검정, 설명력, x변수 유의성 검정  
summary(model)
# 1. F-검정 통계량 : 모델의 유의성 검정 (p-value < 0.05) -> 통계적으로 유의함
# 2. 모델의 설명력 : Adjusted R-squared 0.585
# 3. x변수 유의성 검정 : -18.15   <2e-16 ***
# 엔진크기가 커질 수록 고속주행마일은 전반적으로 감소하는 음의 관계를 띤다.



# 02. product 데이터셋을 이용하여 다음과 같은 단계로 다중회귀분석을 수행하시오.
setwd("c:/Rwork/data")
product <- read.csv("product.csv", header=TRUE)
str(product)

#  단계1 : 학습데이터(train),검정데이터(test)를 7 : 3 비율로 샘플링
pd_idx <- sample(x = nrow(product), size = nrow(product)*0.7, replace = F)

train <- product[pd_idx, ]
test <- product[-pd_idx, ]

dim(train)
dim(test)

#  단계2 : 학습데이터 이용 회귀모델 생성 
#           변수 모델링) y변수 : 제품_만족도, x변수 : 제품_적절성, 제품_친밀도
pd_model <- lm(제품_만족도 ~ ., data = train)


#  단계3 : 검정데이터 이용 모델 예측치 생성 
y_pdpred <- predict(pd_model, test)
y_pdpred

y_pdture <- test$"제품_만족도"
y_pdture

#  단계4 : 모델 평가 : cor()함수 이용  
cor(y_pdture, y_pdpred) # 0.7880317



# 03. ggplot2패키지에서 제공하는 diamonds 데이터 셋을 대상으로 
# carat, table, depth 변수 중 다이아몬드의 가격(price)에 영향을 
# 미치는 관계를 다중회귀 분석을 이용하여 예측하시오.
#조건1) 다이아몬드 가격 결정에 가장 큰 영향을 미치는 변수는?
#조건2) 다중회귀 분석 결과를 정(+)과 부(-) 관계로 해설

library(ggplot2)
data(diamonds)

# diamonds에서 비율척도 대상으로 식 작성 
formula <- price ~ carat +  table + depth
head(diamonds)
model <- lm(formula, data=diamonds) 
summary(model) # 회귀분석 결과

# <해설>carat은 price에 정(+)의 영향을 미치지만, table과 depth는 부(-)의 영향을 미친다.