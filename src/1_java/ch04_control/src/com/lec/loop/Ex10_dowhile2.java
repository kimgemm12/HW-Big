package com.lec.loop;
//컴퓨터가 선택한 로또 번호 맞추기
import java.util.Scanner;

public class Ex10_dowhile2 {
	public static void main(String[] args) {
//		System.out.println(Math.random());   // 0이상 1미만의 난수 실수를 발생  : Math.random()
//		System.out.println(Math.random()*45);// 0이상 45미만의 난수 실수를 발생 :Math.random()*45
//		System.out.println((int)(Math.random()*45));//0~44이상의 난수 정수를 발생
//		System.out.println((int)(Math.random()*45)+1);//1~45이상의 난수 정수를 발생
		Scanner sc = new Scanner(System.in);
		int lotto = (int)(Math.random()*45)+1;  // 컴퓨터가 선택한 로또 번호
		int su; //사용자에게 입력받은 수를 저장하는 변수
		int min = 1;
		int max = 45;
		do {
			System.out.printf("%d부터 %d까지의 번호 중 한개를 맞춰보세요", min,max);
			su = sc.nextInt();
			if(su>lotto){
				System.out.println(su+"보다 작은 수를 도전하세요");
				max = su-1;
			}else if(su<lotto) {
				System.out.println(su+"보다 더 큰 수를 도전하세요");
				min = su+1;
			}
		}while(su!=lotto || min!=max);
		System.out.println("정답입니다.");
	}
}
