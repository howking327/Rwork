#################################
## <제12장_2 연습문제>
################################# 

# 01.  admit 객체를 대상으로 다음과 같이 로지스틱 회귀분석을 수행하시오.
# <조건1> 변수 모델링 : y변수 : admit, x변수 : gre, gpa, rank 
# <조건2> 7:3비율로 데이터셋을 구성하여 모델과 예측치 생성 
# <조건3> 분류 정확도 구하기 

# 파일 불러오기
setwd("c:/Rwork/data")
admit <- read.csv("admit.csv")
str(admit) # 'data.frame':	400 obs. of  4 variables:
#$ admit: 입학여부 - int  0 1 1 1 0 1 1 0 1 0 ...
#$ gre  : 시험점수 - int  380 660 800 640 520 760 560 400 540 700 ...
#$ gpa  : 시험점수 - num  3.61 3.67 4 3.19 2.93 3 2.98 3.08 3.39 3.92 ...
#$ rank : 학교등급 - int  3 3 1 4 4 2 1 2 3 2 ...

# 1. train/test data 구성 
idx <- sample(1:nrow(admit), nrow(admit)*0.7)
train <- admit[idx, ]
test <- admit[-idx, ]

# 2. model 생성 
admit_model <- glm(admit ~ ., data = admit, family = "binomial")
admit_model
summary(admit_model)

# 3. predict 생성 
pred <- predict(admit_model, newdata = test, type = "response")
pred
range(pred, na.rm = T) # 0.07196699 ~ 0.71306804
summary(pred)
str(pred)

cpred <- ifelse(pred>=0.5, 1, 0)
y_true <- test$admit


# 4. 모델 평가(분류정확도) : 혼돈 matrix 이용/ROC Curve 이용
table(y_true, cpred)

# 1) 혼돈 matrix 이용
acc <- (78 + 6) / nrow(test)
acc # 0.7

# 2) ROCR 패키지 제공 함수 : prediction() -> performance
library(ROCR)
pr <- prediction(pred, test$admit)
prf <- performance(pr, measure = "tpr", x.measure = "fpr")
plot(prf)



