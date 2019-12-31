# chap03_FileIO

# 1. 파일 자료 읽기
setwd("c:/Rwork/data")

# (1) read.table() : 칼럼 구분자(공백, 특수문자)
# - 칼럼명이 없는 경우
student <- read.table("student.txt") # default값 -> header=FALSE, sep=""
student # V1   V2  V3 V4 -> 기본 칼럼명

# - 칼럼명이 있는 경우
student1 <- read.table("student1.txt", header = TRUE, sep = "")
student1 # 번호 이름  키 몸무게 -> 지정된 칼럼명
class(student1)

# - 칼럼 구분자가 특수문자인 경우(ex) : , ; , ::)
student2 <- read.table("student2.txt", header = TRUE, sep = ";")
student2

# (2) read.csv() : 칼럼 구분자 콤마(,)
bmi <- read.csv("bmi.csv") # default값 -> header=TRUE, sep=","
bmi
str(bmi)
# 'data.frame':	20000 obs. of  3 variables:
# $ height: int(숫자형)  184 189 183 143 187 161 186 144 184 165 ...
# $ weight: int  61 56 79 40 66 52 54 57 55 76 ...
# $ label : Factor(범주형) w/ 3 levels "fat","normal",..: 3 3 2 2 2 2 3 1 3 1

h <- bmi$height
mean(h)
w <- bmi$weight
mean(w)

table(bmi$label) #범주형 빈도 확인

# label의 자료형을 Factor형이 아닌 문자형 -> 문자형으로 받기
bmi2 <- read.csv("bmi.csv", stringsAsFactors = FALSE)
str(bmi2) # $ label : chr

# 파일 탐색기 이용
test <- read.csv(file.choose()) # test.csv를 선택했음
test

# (3) read.xlsx() : 패키지 설치 필요
install.packages("xlsx")
library(xlsx)

kospi <- read.xlsx("sam_kospi.xlsx", sheetIndex = 1)
kospi
head(kospi)

# 한글이 입력된 엑셀 파일 읽기 : encoding 방식
st_excel <- read.xlsx("studentexcel.xlsx", sheetIndex = 1, encoding = "UTF-8")
st_excel

# 데이터 셋 제공 사이트 
# http://www.public.iastate.edu/~hofmann/data_in_r_sortable.html - Datasets in R packages
# https://vincentarelbundock.github.io/Rdatasets/datasets.html
# https://r-dir.com/reference/datasets.html - Dataset site
# http://www.rdatamining.com/resources/data

# (4) 인터넷 파일 읽기
titanic <- read.csv("https://vincentarelbundock.github.io/Rdatasets/csv/COUNT/titanic.csv")
str(titanic)
dim(titanic)

# 성별 빈도수
table(titanic$sex)
# 생존여부 빈도수
table(titanic$survived)

# 교차 분할표 : 2개의 범주형(행,열)
# 성별에 따른 생존 여부
tab <- table(titanic$sex, titanic$survived)
tab
# 막대 차트로 출력
barplot(tab, col = rainbow(2), main = "생존여부")

# 2. 파일 자료 저장
# 2-1) 화면 출력
a <- 10
b <- 20
c <- a * b
print(c)
c
cat('c =',c)

# 2-2) 파일 저장
# read.csv <-> write.csv
# read.xlsx <-> write.xlsx

getwd()
setwd("c:/Rwork/data/output")
# (1) write.csv() : 콤마 구분자
str(titanic)

# [-1] -> 1칼럼 제거, quote = F -> 따옴표 제거, row.names = F -> 행번호 제거
write.csv(titanic[-1], "titanic.csv", quote = F, row.names = F)
titan <- read.csv("titanic.csv")
head(titan)

# (2) write.xlsx() : 엑셀 파일 저장
library(xlsx)
write.xlsx(kospi, "kospi.xlsx", sheetName = "sheet1", row.names = F)




















