package com.lec.loop;

public class Hw02 {
	public static void main(String[] args) {
		for(int i=1;i<7;i++) {
			for(int j=1;j<7;j++) {
				if(i+j==6) {
					System.out.printf("%d %c %d = %d\n",i,'+',j,i+j);
				}
			}
		}
	}
}
