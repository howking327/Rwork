#################################
## <제6장 연습문제>
################################# 

# 01.  iris 데이터 셋을 대상으로 다음 조건에 맞게 시각화 하시오.
iris
head(iris)

# 조건1) 1번 컬럼 x축, 3번 컬럼 y축으로 차트 작성(힌트 : plot(x, y)
plot(iris$Sepal.Length, iris$Petal.Length)


# 조건2) 5번 컬럼으로 색상 지정(힌트 : plot(x, y, col=컬럼)
plot(iris$Sepal.Length, iris$Petal.Length, col = iris$Species)


# 조건3) "iris 데이터 테이블 산포도 차트" 제목 추가(힌트 : title("차트 제목")
title("iris 데이터 테이블 산포도 차트")


# 02. 다음과 같은 단계별로 히스토그램 시각화하시오.
#  단계1) 표준정규분포를 따르는 난수 1,000개 생성(힌트 : rnorm() 함수 이용)
n = 1000
r <- rnorm(n)

#  단계2) 히스토그램 시각화(각 계급의 밀도 : freq = F) 
hist(r, freq = F)

#  단계3) 정규성 유무 확인 
shapiro.test(r)
# p-value = 0.3898 > alpha = 0.05 : 정규성 채택 





