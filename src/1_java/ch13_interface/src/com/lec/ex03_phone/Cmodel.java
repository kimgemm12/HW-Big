package com.lec.ex03_phone;

public class Cmodel implements IAcor {
	private String na;

	public Cmodel() {
		na="Cmodel";
	}

	public Cmodel(String na) {
		this.na=na;
		
	}

	@Override
	public void dmb() {
		System.out.println(na + "은 DMB 송신 가능");

	}

	@Override
	public void lte() {
		System.out.println(na + "은 LTE");

	}

	@Override
	public void remotec() {
		System.out.println(na + "은 TV리모콘 미탑재");

	}


	public String getNa() {
		return na;
	}

}
