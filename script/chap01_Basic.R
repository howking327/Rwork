# chap01_Basic

# 수업내용 
# 1. session 정보
# 2. R 실행방법
# 3. 패기지와 데이터셋
# 4. 변수와 자료형
# 5. 기본함수 사용 및 작업공간

# 1. session 정보
# session : R을 실행하는 환경
sessionInfo()
# R version, locale(다국어정보), base packages 등을 알 수 있다.

# 2. R 실행방법
# -주요 단축키
# script 실행 : Ctrl + Enter / Ctrl + R
# 자동완성 : Ctrl + space
# 스크립트 저장 : Ctrl + s
# 주석 : #이 유일 여러줄 주석 시 범위 드래그 후 Ctrl + Shift + c(토글)

# 1) 줄 단위 실행
a <- rnorm(n=20) # <- or =
a
hist(a) #histogram 확인
mean(a) #난수 평균값 확인

# 2) 블럭 단위 실행
getwd() # 작업경로
pdf("test.pdf")
hist(a)
dev.off() #close

# 3. 패키지와 데이터셋

# 1) 패키지 = function + [dataset]
# 사용가능한 패키지
dim(available.packages())
# 15328(row)  17(col)

# 패키지 설치/사용
install.packages("stringr")
# 패키지 in memory
library(stringr)

# 사용가능한 패키지 확인
search()

# 설치 위치
.libPaths()

# 패키지 활용
str <- "홍길동35이순신45유관순25"
str

# 이름 추출
str_extract_all(str, "[가-힣]{3}")

# 나이 추출
str_extract_all(str, "[0-9]{2}")

# 패키지 삭제
remove.packages("stringr")

# 2) 데이터셋
data()
data("Nile")
Nile
length(Nile)
mode(Nile)
plot(Nile)
mean(Nile)

# 4. 변수와 자료형
# 1) 변수(variable) : 메모리 주소 저장
# -R의 모든 변수는 객체(참조변수)
# -변수 선언 시 type 없음
a <- c(1:10)
a

# 2) 변수 작성 규칙
# -첫자는 영문자
# -점(.)을 사용(lr.model)
# -예약어 사용 불가
# -대소문자 구분 : num or NUM (서로 다름)

var1 <- 0 # var1 = 0
# java) int var1 = 0
var1
var1 <- 1
var1

var2 <- 10
var3 <- 20
var2; var3

#객체.멤버
member.id <- "hong"
member.name <- "홍길동"
member.pwd <- "1234"

num <- 10
NUM <- 100
num; NUM

# scala(1) / vector(n)
name <- c("홍길동","이순신","유관순")
name

name[2]

# tensor : scala(0), vector(1), matrix(2)

# 변수 목록
ls()

# 3) 자료형
# -숫자형, 문자형, 논리형
int <- 100 #숫자형(연산,차트)
string <- "대한만국" # ''도 가능
boolean <- TRUE # T, FALSE(F)
# 자료형 반환 함수
mode(int)
mode(string)
mode(boolean)

# is.xxx()
is.numeric(int)
is.character(string)
is.numeric(boolean)
is.logical(boolean)

x <- c(100, 90, NA, 65, 78) # NA : 결측치(9999)
is.na(x)

# 4) 자료형 변환(casting)
# 4-1) 문자열 -> 숫자형
num <- c(10,20,20,"40")
num
mode(num)
num <- as.numeric(num)
mode(num)
mean(num)

plot(num)

# 4-2) 요인형(Factor)
# - 동일한 값을 범주로 갖는 집단변수 생성
# ex) 성별) 남(0),여(1) -> 더미변수

gender <- c("M", "F", "M", "F", "M")
mode(gender)
plot(gender) #error발생

# 요인형으로 변환
fgender <- as.factor(gender)
mode(fgender)
fgender
# factor형으로 변환하면 Levels 발생
str(fgender)
plot(fgender)

x <- c('M', 'F')
fgender2 <- factor(gender, levels = x)
str(fgender2)
# 직접 레벨과 변수들을 설정하는 방법
# mode vs class
# mode() : 자료형 반환
# class() : 자료구조 반환
mode(fgender) #"numeric"
class(fgender) #"factor"

# Factor형 고려사항
num <- c(4, 2, 4, 2)
mode(num)

fnum <- as.factor(num)
fnum
# [1] 4(2) 2(1) 4 2
# Levels: 2(1) 4(2)
str(fnum)
# Factor w/ 2 levels "2","4": 2 1 2 1

# 요인형 -> 숫자형 (선언한 값이 아닌 레벨이 숫자형으로 변환된다)
num2 <- as.numeric(fnum)
num2 # 2 1 2 1
# 요인형 -> 문자형 -> 숫자형
snum <- as.character(fnum)
num2 <- as.numeric(snum)
num2 # 4 2 4 2


# 5. 기본함수 사용 및 작업공간
# 5-1) 함수 도움말
mean(10, 20, 30, NA) #평균 - 10
x <- c(10, 20, 30, NA)
mean(x, na.rm = TRUE) # 20
#help(mean) - 특정 함수에 대한 사용법 == ?mean

sum(x, na.rm = TRUE)

# 5-2) 작업공간
getwd()
setwd("c:/Rwork/data")
getwd()

test <- read.csv("test.csv")
test

str(test)
# 'data.frame' : 402 obs. of 5 variables:
# obs. : 관측치 402(행)
# variables : 변수, 변인 5(열)














