//201221 kks runnable
package com.lec.ex1_runnable;

public class Ex02_Target implements Runnable {

	@Override
	public void run() {
		for (int i = 0; i < 10; i++) {
			System.out.println("�ݰ����ϴ�. -" + i);
			try {
				Thread.sleep(500);
			} catch (InterruptedException e) {
				System.out.println(e.getMessage());
			}
		}
	}

}
