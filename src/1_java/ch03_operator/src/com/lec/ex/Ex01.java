package com.lec.ex;
// 산술연산자(+,=,*,/,%)
public class Ex01 {
	public static void main(String[] args){
		int n1 = 33, n2 = 10;
		int result;
		double resultDouble;
		result = n1+n2;
		System.out.printf("%d %c %d = %d\n", n1, '+', n2, result);
		result = n1-n2;
		System.out.printf("%d %c %d = %d\n", n1, '-', n2, result);
		result = n1*n2;
		System.out.printf("%d %c %d = %d\n", n1, '*', n2, result);
		result = n1/n2; //나누는 수가 0이 아니어야 한다. 4byte끼리의 연산은 4byte만 나온다.
		System.out.printf("%d %c %d = %d\n", n1, '/', n2, result);
		resultDouble = (double)n1 / n2;
		System.out.printf("%d %c %d = %.1f\n", n1, '/', n2, resultDouble);
		result = n1%n2;
		System.out.printf("%d %c %d = %d\n", n1, '%', n2, result);
		// 나머지 연산자의 쓰임새
		if (n1%2==0)
			System.out.println("짝수");
		else
			System.out.println("홀수");
		
	}//프로그램끝

}//class끝
