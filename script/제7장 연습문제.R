#################################
## <제7장 연습문제>
################################# 

# 01. 본문에서 생성된 dataset2의 resident 칼럼을 대상으로 NA 값을 제거하시오.(힌트 : subset()함수 이용)
summary(dataset2) #NA's 15 발견
dataset2 <- subset(dataset2, resident >= 1 & resident <= 5)
plot(dataset2$resident)

# 02. dataset2의 gender 칼럼을 대상으로 1->"남자", 2->"여자" 형태로 코딩 변경하여 
# gender2 칼럼에 추가하고, 파이 차트로 결과를 확인하시오.
pie(table(dataset2$gender))
gender2 <- ""
for(i in 1:nrow(dataset2)){
  if(dataset2$gender[i] == 1){
    gender2[i] <- "남자"
  }else{
    gender2[i] <- "여자"
  }
}
dataset2$gender2 <- gender2

dataset2[c("gender", "gender2")]

pie(table(dataset2$gender2))

# 03. 나이를 30세 이하 -> 1, 31~55 -> 2, 56이상 -> 3 으로 코딩변경하여 age2 칼럼에 추가한 후 
# age, age2 칼럼만 확인하시오.
age2 <- 0
for(i in 1:nrow(dataset2)){
  if(dataset2$age[i] <= 30){
    age2[i] <- 1
  }else if(dataset2$age[i] <= 55){
    age2[i] <- 2
  }else{
    age2[i] <- 3
  }
}
dataset2$age2 <- age2
dataset2[c("age", "age2")]

dataset2$age3[dataset2$age <= 30] <- "청년층"
dataset2$age3[dataset2$age > 30 & dataset2$age <= 55] <- "중년층"
dataset2$age3[dataset2$age > 55] <- "장년층"

dataset2[c("age", "age2", "age3")]


# 04. ggplot2 패키지에서 제공하는 mpg 데이터셋의 hwy 변수를 대상으로 이상치를 발견하고, 제거하시오.
install.packages("ggplot2")
library(ggplot2)
mpg <- as.data.frame(mpg)

# 단계1) 상자그래프와 통계량 
boxplot(mpg$hwy)$stats

# 단계2) 이상치 제거 
mpg2 <- subset(mpg, hwy >= 12 & hwy <= 37)
boxplot(mpg2$hwy)

# 05. iris 데이터셋을 대상으로 8:2비율로 sampling하여 train과 test 셋을 만드시오.
# 정답 확인 필요




