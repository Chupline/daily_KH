package polymorphism;

import org.springframework.context.support.AbstractApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;
import polymorphism.TV;

public class TVUser {
    public static void main(String[] args) {
        // 1. Spring 컨테이너를 구동한다.
        AbstractApplicationContext factory = 
            new GenericXmlApplicationContext("context.xml");
        
        // 2. Spring 컨테이너로0부터 필요한 객체를 요청(Lookup)한다.
        TV tv = (TV)factory.getBean("tv");
        tv.powerOn();
        tv.volumeUp();
        tv.volumeDown();
        tv.powerOff();
        
        // 3. Spring 컨테이너를 종료한다.
        factory.close();

    }
}

