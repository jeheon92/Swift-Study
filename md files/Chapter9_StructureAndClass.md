# Chapter9 구조체와 클래스  
하나의 새로운 사용자정의 데이터 타입을 만들어 주는 것  
**구조체**의 인스턴스는 **값 타입**  
**클래스**의 인스턴스는 **참조 타입**  

## 9.1 구조체  
### 9.1.1 구조체 정의  
- 구조체는 struct 키워드로 정의한다.  
- 구조체 기본 이름은 UpperCamelCase, 프로퍼티와 메서드는 lowerCamelCase 명명법을 따른다.

   ```swift
   struct 구조체 이름 {  
      프로퍼티와 메서드들  
   }  
   
   struct BasicInfomation {  
      var name: String  
      var age: Int  
   }  
   ```  

### 9.1.2 구조체 인스턴스의 생성 및 초기화  
- 멤버와이즈 이니셜라이저를 사용하여 구조체의 인스턴스를 생성하고 초기화한다.  
  > 구조체에 기본 생성된 이니셜라이저의 매개변수는 구조체의 프로퍼티 이름으로 자동 지정된다.  
  > 기본 제공되는 멤버와이즈 이니셜라이저 외에 사용자정의 이니셜라이저도 구현 가능

- 구조체 인스턴스의 프로퍼티 값에 접근하고 싶다면 마침표(.)를 사용한다.
- 구조체를 상수 let으로 선언하면 인스턴스 내부의 프로퍼티 값을 변경할 수 없다. (값 타입)


   ```swift
   struct BasicInfomation {  
      var name: String  
      var age: Int  
   }  

   // 프로퍼티 이름(name, age)으로 자동 생성된 이니셜라이저를 사용하여 구조체를 생성합니다.
   // BasicInformation(name: <String>, age: <Int>)  // 멤버와이즈 이니셜라이저
   
   var jeheonInfo: BasicInformation = BasicInformation(name: "jeheon", age: 26)
   jeheonInfo.age = 100
   
   
   let jennyInfo: BasicInformation = BasicInformation(name: "Seba", age: 99)
   jennyInfo.age = 100         // 변경 불가!
   
   ```  

## 9.2 클래스  
스위프트의 클래스는 부모클래스가 없더라도 상속 없이 단독으로 정의가 가능하다.  

### 9.2.1 클래스 정의  
- 클래스는 class 키워드를 사용한다.  
- 구조체와 마찬가지로, 클래스 기본 이름은 UpperCamelCase, 프로퍼티와 메서드는 lowerCamelCase 명명법을 따른다.  

   ```swift
   class 클래스 이름 {  
      프로퍼티와 메서드들  
   }  
   
   // 상속 받는 클래스의 경우
   class 클래스 이름: 부모클래스 이름 {  
      프로퍼티와 메서드들  
   }  
   
   class Person {  
      var height: Float = 0.0  
      var weight: Float = 0.0  
   }  
   ```  
   
### 9.2.2 클래스 인스턴스의 생성과 초기화  
- 이니셜라이저를 사용하여 클래스의 인스턴스를 생성하고 초기화한다.  
- 클래스 인스턴스의 프로퍼티 값에 접근하고 싶다면 마침표(.)를 사용한다.  
- 클래스를 상수 let으로 선언해도 인스턴스 내부의 프로퍼티 값을 변경할 수 있다. (참조 타입)  

   ```swift
   class Person {  
      var height: Float = 0.0  
      var weight: Float = 0.0  
   }
      
   // Person 클래스의 인스턴스 생성 및 사용
   var jehoen: Person = Person()
   yagom.height = 123.4
   yagom.weight = 123.4
   
   let jenny: Person = Person()
   jenny.height = 123.4
   jenny.weight = 123.4
   
   ```  
   
### 9.2.3 클래스 인스턴스의 소멸  
- 클래스의 인스턴스는 참조 타입이므로 더는 참조할 필요가 없을 때 메모리에서 해제된다.</br>
  이 과정을 소멸이라 칭하는데 소멸되기 직전 deinit라는 **디이니셜라이저(Deinitializer)** 메서드가 호출된다.
	> deinit 메서드는 클래스당 하나만 구현할 수 있으며, 매개변수와 반환 값을 가질 수 없다.  
	> 매개변수를 위한 소괄호도 적어주지 않는다.  
	> 보통 인스턴스가 메모리에서 해제되기 직전에 처리할 코드를 넣어준다.  

   ```swift
   class Person {
       var height: Float = 0.0
       var weight: Float = 0.0
       
       deinit {
           print("Person 클래스의 인스턴스가 소멸됩니다.")
       }
   }
   
   var yagom: Person? = Person()
   yagom = nil     // Person 클래스의 인스턴스가 소멸됩니다.
   ```  
   
## 9.3 구조체와 클래스의 차이  
### 같은 점
- 값을 저장하기 위해 프로퍼티를 정의할 수 있다.
- 기능 수행을 위해 메서드를 정의할 수 있다.
- 서브스크립트 문법을 통해 구조체 또는 클래스가 가지는 값(프로퍼티)에 접근하도록 서브스크립트를 정의할 수 있다. ??
- 초기화될 때의 상태를 지정하기 위해 이니셜라이저를 정의할 수 있다.
- 초기구현과 더불어 새로운 기능 추가를 위해 익스텐션을 통해 확장할 수 있다.
- 특정 기능을 수행하기 위해 특정 프로토콜을 준수할 수 있다.

### 다른 점
> 값 타입, 참조 타입 차이에서 생긴 다른 점들  

- 구조체는 상속이 없다.
- 타입캐스팅은 클래스의 인스턴스에만 허용된다.
- 디이니셜라이저는 클래스의 인스턴스에만 활용할 수 있다.
- 참조 횟수 계산 (Reference Counting)은 클래스의 인스턴스에만 적용된다.

### 9.3.1 값 타입과 참조 타입
- 값 타입과 참조 타입의 가장 큰 차이는 '무엇이 전달되느냐'</br>
  값 타입은 값을 **복사**하여 전달하고, 참조 타입은 **참조(주소)**가 전달된다.  
  
  > 포인터와 매우 유사한 개념, 그러나 스위프트에서는 참조라는 것을 표현해주기 위해 애스터리스크(*)를 사용하지는 않는다.
  
- 값 타입의 데이터가 함수의 전달인자로 전달되면 메모리에 전달인자를 위한 인스턴스가 새로 생성된다.</br>
  참조 타입의 데이터가 함수의 전달인자로 전달되면 기존 인스턴스가 참조가 전달되어 사용된다.</br>
  이는 함수의 전달인자뿐만 아니라 새로운 변수에 할당될 때 또한 마찬가지  

  > 클래스의 인스턴스끼리 참조가 같은지 확인하려면 식별 연산자를 사용한다. (===, !==) 
 
  ```swift
   // 코드 9-6 값 타입과 참조 타입의 차이
   struct BasicInformation {
       let name: String
       var age: Int
   }
   
   var yagomInfo: BasicInformation = BasicInformation(name: "yagom", age: 99)
   yagomInfo.age = 100
   
   var friendInfo: BasicInformation = yagomInfo    // yagomInfo의 값을 복사하여 할당합니다!
   
   print("yagom's age : \(yagomInfo.age)")         // 100
   print("friend's age : \(friendInfo.age)")       // 100
   
   friendInfo.age = 999
   
   print("yagom's age : \(yagomInfo.age)")         // 100 - yagom의 값은 변동 없습니다.
   print("friend's age : \(friendInfo.age)")       // 999 - friendInfo는 yagomInfo의 값을 복사해왔기 때문에
   // 별개의 값을 가집니다.
   
   
   class Person {
       var height: Float = 0.0
       var weight: Float = 0.0
   }
   
   var yagom: Person = Person()
   
   var friend: Person = yagom                      // yagom의 참조를 할당합니다!
   
   print("yagom's height : \(yagom.height)")       // 0.0
   print("friend's height : \(friend.height)")     // 0.0
   
   friend.height = 185.5
   
   print("yagom's height : \(yagom.height)")       // 185.5 - friend는 yagom을 참조하기 때문에 값이 변동됩니다.
   print("friend's height : \(friend.height)")     // 185.5 - 이를 통해 yagom이 참조하는 곳과
   // friend가 참조하는 곳이 같음을 알 수 있습니다.
   
   
   
   func changeBasicInfo(_ info: BasicInformation) {
       var copiedInfo: BasicInformation = info
       copiedInfo.age = 1
   }
   
   func changePersonInfo(_ info: Person) {
       info.height = 155.3
   }
   
   
   changeBasicInfo(yagomInfo)
   print("yagom's age : \(yagomInfo.age)")         // 100 - changeBaiscInfo(_:)로 전달되는 전달인자는
   // 값이 복사되어 전달되기 때문에 yagomInfo의 값만 전달되는 것입니다.
   
   changePersonInfo(yagom)
   print("yagom's height : \(yagom.height)")         // 155.3 - changePersonInfo(_:)의 전달인자로
   // yagom의 참조가 전달되었기 때문에 yagom이 참조하고 있는 값들의 변화가 생깁니다.
   ```  
  
  
### 9.3.2 스위프트의 기본 데이터 타입은 모두 구조체다. (제곧내)  
- 이런 점을 더욱 확실히 하기 위해 스위프트의 전달인자는 모두 상수로 취급되어 전달되는 것일지도 모릅니다. (?)

## 9.4 구조체와 클래스 선택해서 사용하기
- 애플은 가이드라인에서 다음 조건 중 하나 이상에 해당된다면 구조체를 사용하기를 권한다.  
	- 연관된 간단한 값의 집합을 캡슐화하는 것만이 목적일 때
	- 캡슐화된 값이 참조되는 것보다 복사되는 것이 합당할 때
	- 구조체에 저장된 프로퍼티가 값 타입이며 참조되는 것보다 복사되는 것이 합당할 때
	- 다른 타입으로부터 상속받거나 자신이 상속될 필요가 없을 때

  > 스위프트의 기본 데이터 타입이 모두 구조체라서  
  > 매번 데이터를 복사하고 이용할 때 메모리를 비효율적으로 사용한다고 오해할 수 있으나,  
  > 스위프트가 알아서 효율적이게 처리 잘해준다고 함.  
  > (개념상으론 복사지만, 진짜 메모리 상에선 복사는 잘 안일어나게)