package com.lec.ex;
// Car myPorsche = new Car();
// 칼러 바꾸기 myPorsche.color = "red";
public class Car { 
	//데이터
	private String color; //class에는 일반적으로 데이터(private), 메소드(public) 
	private int cc;
	private int speed;
	
	public Car() {
		// 생성자 함수 = 리턴타입이 없고 클래스명과 같은 이름의 메소드 . 클래스 사용시 데이터와 메소드 사이에 자동으로 생긴다
		// 디폴트 생성자함수는 생성자 함수가 없을 때 JVM이 자동생성.
		// 객체변수가 생성될 때 자동 호출
		cc=1000; 
		
	}
	
	//메소드
	public void drive() {
		speed = 60;
		System.out.println("운전한다 지금 속도 : "+ speed);
	}
	void park() { //public 안쓰면 public 안쓴것과 같다. 디폴트 느낌?
		speed = 0;
		System.out.println("주차한다 지금 속도 : "+ speed);
	}
	void race() {
		speed = 120;
		System.out.println("레이싱 한다 지금 속도 :"+ speed);
	}
	//private기 때문에 color, cc, speed를 가져가거나(get) 변경할(set) 메소드를 만들어야한다.
	//set메소드 ex)~.set~()
	public void setColor(String color) {
		this.color = color;
	}
	public void setCc(int cc) {
		this.cc = cc;
	}
	//get메소드 ex)~.get~()
	public String getColor() {
		return color;
	}
	public int getCc() {
		return cc;
	}
}
//class의 구조 : 1.데이터 2.생성자 함수 3.메소드 4.set함수5.get 함수