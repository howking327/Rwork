# chap04_Control

# 제어문 : 조건문과 반복문

# <실습> 산술연산자 
num1 <- 100 # 피연산자1
num2 <- 20  # 피연산자2
result <- num1 + num2 # 덧셈
result # 120
result <- num1 - num2 # 뺄셈
result # 80
result <- num1 * num2 # 곱셈
result # 2000
result <- num1 / num2 # 나눗셈
result # 5

result <- num1 %% num2 # 나머지 계산
result # 0

result <- num1^2 # 제곱 계산(num1 ** 2)
result # 10000
result <- num1^num2 # 100의 20승
result # 1e+40 -> 1 * 10의 40승과 동일한 결과


# <실습> 관계연산자 
# (1) 동등비교 
boolean <- num1 == num2 # 두 변수의 값이 같은지 비교
boolean # FALSE
boolean <- num1 != num2 # 두 변수의 값이 다른지 비교
boolean # TRUE

# (2) 크기비교 
boolean <- num1 > num2 # num1값이 큰지 비교
boolean # TRUE
boolean <- num1 >= num2 # num1값이 크거나 같은지 비교 
boolean # TRUE
boolean <- num1 < num2 # num2 이 큰지 비교
boolean # FALSE
boolean <- num1 <= num2 # num2 이 크거나 같은지 비교
boolean # FALSE

# <실습> 논리연산자(and, or, not, xor)
logical <- num1 >= 50 & num2 <=10 # 두 관계식이 같은지 판단 
logical # FALSE
logical <- num1 >= 50 | num2 <=10 # 두 관계식 중 하나라도 같은지 판단
logical # TRUE

logical <- num1 >= 50 # 관계식 판단
logical # TRUE
logical <- !(num1 >= 50) # 괄호 안의 관계식 판단 결과에 대한 부정
logical # FALSE

x <- TRUE; y <- FALSE
xor(x,y) # [1] TRUE
x <- TRUE; y <- TRUE
xor(x,y) # FALSE


# 1. 조건문

# (1) if("조건식"){}
x <- 10
y <- 5
z <- x*y
z

if(z >= 50){
  print("z는 50 이상이다.")
}else{
  print("z는 50 미만이다.")
}

# 학점 구하기
score <- scan() #키보드값을 입력받는다.
score

grade <- "" #등급 변수 선언
if(score>=90){
  grade <- "A학점"
}else if(score>=80){
  grade <- "B학점"
}else if(score>=70){
  grade <- "C학점"
}else{
  grade <- "F학점"
}
cat("획득한 점수는 ",score,"점으로 ",grade, "등급입니다." )

# 배수 구하기
10 / 2
10 %% 2
10 %% 3
# 응용 문제) 키보드 입력 숫자가 5의 배수인지 판별하시오.
keynum <- scan()
if((keynum%%5) == 0){
  cat(keynum, "는 5의 배수이다.")
}else{
  cat(keynum, "는 5의 배수가 아니다.")
}

# (2) ifelse() : if + else
# 형식 ) ifelse(조건식, 참, 거짓) - 3항 연산자
# vector(n) -> 처리 -> vector(n)
score <- c(90, 65, 70, 80, 59)
score

result <- ifelse(score>=70, "합격", "불합격")
result

# 결측치 처리 : NA -> 0점으로 처리
score2 <- c(90, 65, NA, 80, 59)
result2 <- ifelse(is.na(score2), 0, score2)
result2

sum(score2)
sum(score2, na.rm = T) # NA를 제외한 나머지의 합 계산
sum(result2)

# (3) which() : 조건에 해당하는 위치(index)를 반환
x <- seq(1, 10, 3)
x

which(x == 7)

# 행렬구조 위치 반환
emp <- read.csv("c:/Rwork/data/emp.csv")
emp
class(emp)
emp[1,2] <- "유관순"

idx <- which(emp$name == "유관순")
idx

# subset
emp_sub <- emp[idx, ]
emp_sub

# 변수 선택 example
library("MASS")
data("Boston")

str(Boston)
# data.frame : 506 obs. of 14 variables:
# 1 ~ 13 : x변수(독립변수)
# medv : y변수(종속변수)

# 칼럼 가져오기
cols <- names(Boston)
cols #[1] "crim" ~ [14] "medv"

idx <- which(cols == "medv")
idx

y <- Boston[ ,idx]
x <- Boston[ ,-idx] # 14칼럼 제외 나머지

y #vector 정보
dim(x)


# 2. 반복문

# (1) for(변수 in 값){반복문}
x <- rnorm(n = 10, mean = 0, sd = 1)
x
length(x)

y <- 0 # x^2

idx <- 1 #index
for(v in x){
  cat("v = ",v, "\n")  
  y[idx] <- v^2 #vector에 저장
  idx <- idx + 1 #카운터
}

y

i <- 1:10
i
for(v in i){
  #print(v)
  #짝수만 출력 or 홀수만 출력
  if(v %% 2 != 0)
    print(v)
}

# 키보드 입력 -> 홀수 출력하기
num <- scan()
num
for(var in num){
  if(var %% 2 != 0)
    print(var)
}

# 1~100 까지 홀수의 합과 짝수의 합 출력
even <- 0 # 짝수 합
odd <- 0 # 홀수 합
num <- 1:100
num
for(v in num){
  if(v %% 2 == 0){
    even <- even + v
  }else{
    odd <- odd + v
  }
}
cat("짝수 합 : ", even, "홀수 합 :", odd)

setwd("c:/Rwork/data")
st <- read.table("student.txt")
st

colnames(st) <- c("S_id", "s_name", "s_height", "s_weight")
st

height <- ifelse(st$s_height >= 180, "위너?", "루저?")
weight <- ifelse(st$s_weight >= 65, "오~", "흐에엑?")

st$height <- height
st$weigth <- weight

st

# (2) while(조건식){반복문}
i = 0 # 변수 초기화
while (i<10) {
  print(i)
  i <- i + 1 # 카운터
}

# while + index : x의 각 변량에 제곱
x <- c(2, 5, 8, 6, 9)
x
y <- 0 # y = x^2

i <- 0 # 카운터 변수
while(i < length(x)){
  i <- i + 1
  cat("y = ", x[i]^2, "\n")
  y[i] <- x[i]^2
}

# while() -> for()
i <- 0
y <- 0
for(v in x){
  i <- i + 1
  y[i] <- v^2
}
y














