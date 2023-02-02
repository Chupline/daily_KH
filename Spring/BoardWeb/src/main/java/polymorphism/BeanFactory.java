package polymorphism;

public class BeanFactory {
    public Object getBean(String beanName){
        if(beanName.equals("samsung")){
            return new SamsungTV(new SonySpeaker());
        } else if(beanName.equals("lg")){
            return new LgTV();
        }
        return null;
    }

}
