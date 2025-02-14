package com.lec.ex;

public class Ex01 {
	public static void main(String[] args) {
		// 1. 배열의 선언과 초기화 동시에
		int[] iArr = {10,20,30,40,50}; 
		iArr[1] = 200; // 배열은 index로 접근(현재 index: 0~4)
		for(int idx = 0; idx<5; idx++) { //일반 for문
			System.out.println(iArr[idx]);
		}
		
		// 2. 배열 변수 선언과 배열메모리 공간 확보,쓰레기 데이터 다 치우고 공간은 0으로 세팅된다.
		int[] iArr2 =new int[5]; 
		iArr2[0] =999;
		for(int idx =  0; idx<iArr2.length ;  idx++) { //idx<iArr2.length = idx <5
			System.out.println(idx+"번째값 : "+iArr2[idx]);
		}
		
		// 3. 배열 변수 선언
		int[] iArr3;
		iArr3 = new int[5]; //0 0 0 0 0 
//		for(int idx=0; idx<iArr3.length; idx++) { //일반 for문
//			iArr3[idx]= idx+1;
//		}
		for(int temp : iArr3) {//확장 for문으로 값 변경 안된당
			temp = 10;
		}
		for(int temp : iArr3) { //확장 for문 - 값을 출력할때나, 값을 넣고싶을때만 쓴다. 확장 for문으로는 값은 변경 못한다,
			System.out.println(temp);
			
		}
		for(int idx=0; idx<iArr3.length; idx++) {
			iArr3[idx] = 10;
		}
		for(int temp : iArr3) { 
			System.out.println(temp);
			
		}
	}
}
