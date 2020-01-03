# chap11_Correlation

# dataset 가져오기
product <- read.csv("product.csv")
str(product)
# 각 항목에 대한 5점(등간척도)
# 'data.frame':	264 obs. of  3 variables:
# $ 제품_친밀도: int  3 3 4 2 2 3 4 2 3 4 ...
# $ 제품_적절성: int  4 3 4 2 2 3 4 2 2 2 ...
# $ 제품_만족도: int  3 2 4 2 2 3 4 2 3 3 ...

# 1. 상관분석
# - 두 변수의 확률분포의 상관관계 정도를 나타내는 계수(-1 ~ +1)

corr <- cor(product, method = "pearson") # 상관계수 행렬 제공
#              제품_친밀도 제품_적절성 제품_만족도
# 제품_친밀도   1.0000000   0.4992086   0.4671450
# 제품_적절성   0.4992086   1.0000000   0.7668527
# 제품_만족도   0.4671450   0.7668527   1.0000000
cor(x=product$제품_적절성, y=product$제품_만족도)

# 2. 상관분석 시각화
install.packages("corrplot")
library(corrplot)

corrplot(corr, method = "number")
corrplot(corr, method = "square")
corrplot(corr, method = "circle")

install.packages("PerformanceAnalytics")
library(PerformanceAnalytics)
chart.Correlation(product)

# 3. 공분산
# - 두 변수의 확률분포의 상관관계 정도를 나타내는 값

# 상관계수 와 공분산
# 상관계수 : 두 변수의 크기 , 방향 (-,+)
# 공분산 : 크기

cov(product) # 공분산 행렬
#              제품_친밀도 제품_적절성 제품_만족도
# 제품_친밀도   0.9415687   0.4164218   0.3756625
# 제품_적절성   0.4164218   0.7390108   0.5463331
# 제품_만족도   0.3756625   0.5463331   0.6868159


###############
## iris 적용 
###############
cor(iris[-5])

# 양의 상관계수 (0.9628654)
plot(iris$Petal.Length, iris$Petal.Width)

# 음의 상관계수 (-0.4284401)
plot(iris$Sepal.Width, iris$Petal.Length)















