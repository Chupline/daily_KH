package polymorphism;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

@Component("tv")
public class LgTV implements TV {
	//@Autowired //타입으로 DI (의존성 주입)
	//@Inject // Autowired와 동일
	//@Qualifier("sony") //이름으로 DI
	//@Resource(name = "sony") // Autowired + Qualifier : 타입 또는 이름으로 DI
	private Speaker speaker;

	public LgTV() {
		System.out.println("===> LgTV 객체 생성됨");
	}

	public void powerOn() {
		System.out.println("LgTV---전원 켠다.");
	}

	public void powerOff() {
		System.out.println("LgTV---전원 끈다.");
	}

	public void volumeUp() {
		speaker.volumeUp();
		//System.out.println("LgTV---소리 올린다.");
	}

	public void volumeDown() {
		speaker.volumeDown();
		//System.out.println("LgTV---소리 내린다.");
	}
}
