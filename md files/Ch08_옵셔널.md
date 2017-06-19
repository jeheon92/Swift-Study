# Chapter8 옵셔널  
'선택적인', 즉 값이 '있을 수도, 없을 수도 있음'을 나타내는 표현  
옵셔널과 옵셔널이 아닌 값은 철저히 다른 타입으로 인식

## 8.1 옵셔널 사용  
- DataType?  
   ```var myName: String? = "yagom"```  

- Optional < DataType >  
   ```var myName: Optional<String> = "yagom"```  

  > 물음표를 붙여주는 것이 조금 더 편하고 읽기도 쉽기 때문에 굳이 긴 표현을 사용하진 않음

  


- 옵셔널 변수 또는 상수가 아니면 nil 할당 불가 (= 옵셔널 자료형에만 nil을 사용할 수 있다.)   
 
  > ""(빈 문자열)과 nil은 다르다.  
- 함수형 프로그래밍 패러다임에서 자주 등장하는 모나드(Monad) 개념과 일맥상통하다.  
- 해당 변수 또는 상수가 nil일 수도 있으므로 사용에 주의  
  > 값이 없는 옵셔널 변수 또는 상수에(강제적으로) 접근하려면 런타임 오류 발생 (워닝이 발생하지, 오류 발생 안하는 듯??)  
  > nil이어도 죽지 않음, 그대로 nil 나옴.  
  > 단, !로 강제 추출했을 땐, 오류 발생
  
- 옵셔널은 열거형이다.  

  ```swift
  public enum Optional<Wrapped> : ExpressibleByNilLiteral {
      case none
      case some(Wrapped)
      
      public init(_ some: Wrapped)
      /// 중략・・・
  }
  ```
  > 옵셔널 자체가 열거형이기 때문에, 옵셔널 변수는 switch구문을 통해 값이 있고 없음을 확인할 수 있다.  

  ```swift
  public enum Optional<Wrapped> : ExpressibleByNilLiteral {
      case none
      case some(Wrapped)
      
      public init(_ some: Wrapped)
      /// 중략・・・
  }
  ```  




## 8.2 옵셔널 추출  
> 열거형의 some 케이스로 wrapped된 **옵셔널의 값을 옵셔널이 아닌 값으로 추출**하는 방법 (Optional Unwrapping)  

### 8.2.1 강제 추출  
- 옵셔널의 값을 추출하는 가장 간단하지만 **가장 위험한 방법**  
- nil이면 런타임 오류 발생! 런타임 오류의 가능성을 항상 내포하고 있기 때문에 옵셔널 강제 추출 방식은 사용을 지양하길.

  ```swift
  var errorTest: Int?
  print(errorTest!)	// nil이므로 런타임 오류 발생!
  ```

### 8.2.2 옵셔널 바인딩  
- 옵셔널에 값이 있는지 확인할 때 사용
- 만약, 옵셔널에 값이 있다면 옵셔널에서 추출된 값을 일정 블록안에서 사용할 수 있는 상수나 변수로 할당해서 옵셔널이 아닌 형태로 사용할 수 있도록 해준다.  
- if 또는 while 구문 등과 결합하여 사용할 수 있다.  

  ```swift
  // 코드 8-7 옵셔널 바인딩을 사용한 옵셔널 값의 추출
  var myName: String? = "yagom"
  
  // 옵셔널 바인딩을 통한 임시 상수 할당
  if let name = myName {
      print("My name is \(name)")
  } else {
      print("myName == nil")
  }
  // My name is yagom
  
  // 옵셔널 바인딩을 통한 임시 변수 할당
  if var name = myName {
      name = "wizplan"   // 변수이므로 내부에서 변경이 가능합니다.
      print("My name is \(name)")
  } else {
      print("myName == nil")
  }
  // My name is wizplan
  ```

- 이렇게 여러개의 옵셔널 값을 추출할 수도 있다.  

  ```swift
  // 코드 8-8 옵셔널 바인딩을 사용한 여러개의 옵셔널 값의 추출
  myName = "yagom"
  var yourName: String? = nil
  
  // friend에 바인딩이 되지 않으므로 실행되지 않습니다.
  if let name = myName, let friend = yourName {
      print("We are friend!")
  }
  
  yourName = "eric"
  
  if let name = myName, let friend = yourName {
      print("We are friend! \(name) & \(friend)")
  }
  // We are friend! yagom & eric
  ```
- 옵셔널 바인딩은 옵셔널 체이닝과 환상의 결합을 이룬다고 함

### 8.2.3 암시적 추출 옵셔널  
- nil을 할당할 수 있으며, 일반 자료형 변수 또는 상수처럼 사용 가능  
- 그러나 nil이 할당되어 있을 때 접근을 시도하면 런타임 오류 발생(한다고 책에는 나와있으나 오류발생 안함)  
- C,  등 다른 언어에서의 일반 변수, 상수와 다를 것 없음 nil로 인한 에러발생도 없음 (warning도 없음)

  ```swift
  // 코드 8-9 암시적 추출 옵셔널의 사용
  var myName: String! = "yagom"
  
  print(myName)   // yagom

  myName = nil
  
  // 암시적 추출 옵셔널도 옵셔널이므로 당연히 바인딩을 사용할 수 있습니다.
  if var name = myName {
      print("My name is \(name)")
  } else {
      print("myName == nil")
  }
  // myName == nil
  
  print(myName)   // 오류!! 발생 안함..
  ```

- 옵셔널 바인딩, nil 병합 연산자, 옵셔널 체이닝 등의 방법을 사용하는 편이 훨씬 안전하고, 스위프트 지향점에 부합한다.

  


