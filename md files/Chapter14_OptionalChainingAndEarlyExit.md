# Chapter14 옵셔널 체이닝과 빠른종료  
> 옵셔널 체이닝이 없다면 옵셔널은 정말로 귀찮고 또 귀찮은 존재  

## 14.1 옵셔널 체이닝  
> 옵셔널을 반복 사용하여 옵셔널이 자전거 체인처럼 서로 꼬리를 물고있는 모양이기 때문에 옵셔널 체이닝이라고 부른다.  

- 옵셔널 변수나 상수 뒤에 물음표(?)를 붙여 표현한다.  
- 옵셔널이 nil이 아니라면 정상적으로 호출될 것이고, nil이라면 결괏값으로 nil을 반환한다.  
  
  > 결과적으로 nil이 반환될 가능성이 있으므로 **옵셔널 체이닝의 반환된 값은 항상 옵셔널**이다.  

  > 옵셔널 강제추출(!)은 추출하고자 하는 옵셔널이 nil일때 오류 발생! 100%  
  > 강제추출(!)은 nil이 아니라는 확신을 하더라도 사용을 지양하는 편이 좋다.

	```swift
	// 코드14-1 사람의 주소정보 표현 설계
	class Room {    // 호실
	    var number: Int             // 호실 번호
	
	    init(number: Int) {
	        self.number = number
	    }
	}
	
	class Building {    // 건물
	    var name: String           // 건물이름
	    var room: Room?	   // 호실정보
	
	    init(name: String) {
	        self.name = name
	    }
	}
	
	struct Address {    // 주소
	    var province: String        // 광역시/도
	    var city: String            // 시/군/구
	    var street: String          // 도로명
	    var building: Building?     // 건물
	    var detailAddress: String?  // 건물 외 상세주소
	}
	
	class Person {  // 사람
	    var name: String            // 이름
	    var address: Address?       // 주소
	    
	    init(name: String) {
	        self.name = name
	    }
	}
	
	
	// 코드 14-2 인스턴스 생성
	let jeheon: Person = Person(name: "jeheon")
	
	
	// 코드 14-3 옵셔널 체이닝 문법!!
	let jeheonRoomViaOptionalChaining: Int? = jeheon.address?.building?.room?.number		// nil
	let jeheonRoomViaOptionalUnwraping: Int! = jeheon.address!.building!.room!.number		// 오류 발생!!  
	```  


- 옵셔널 바인딩과 옵셔널 체이닝은 환상의 궁합을 자랑한다.  

  	```swift  
  	// 코드 14-4 옵셔널 바인딩'만' 사용
  	let yagom: Person = Person(name: "yagom")
	var roomNumber: Int? = nil
	
	if let yagomAddress: Address = yagom.address {
	    if let yagomBuilding: Building = yagomAddress.building {
	        if let yagomRoom: Room = yagomBuilding.room {
	            roomNumber = yagomRoom.number
	        }
	    }
	}
		
	if let number: Int = roomNumber {
	    print(number)   
	} else {
	    print("Can not find room number")
	}
	   
	
	// 코드 14-5 옵셔널 체이닝의 사용 (+ 옵셔널 바인딩)
	let yagom: Person = Person(name: "yagom")
	
	if let roomNumber: Int = yagom.address?.building?.room?.number {
	    print(roomNumber)
	} else {
	    print("Can not find room number")
	}
	
	// 이렇게 "옵셔널 체이닝 + 옵셔널 바인딩"으로 표현하는게 훨씬 간단해집니다.
	
	```

- 옵셔널 체이닝을 통해 메서드와 서브스크립트 호출도 가능하다. (메서드 반환 타입이 옵셔널일 경우)  
	> 서브스크립트는 인덱스를 통해 값을 넣고 빼올 수 있는 기능이다.  

	```swift
	// 역시 야곰님 코드 예제가 직방! / 260p
	
	// 코드 14-1 사람의 주소정보 표현 설계
	class Room {    // 호실
	    var number: Int             // 호실 번호
	
	    init(number: Int) {
	        self.number = number
	    }
	}
	
	class Building {    // 건물
	    var name: String           // 건물이름
	    var room: Room?	   // 호실정보
	
	    init(name: String) {
	        self.name = name
	    }
	}
	
	// 코드 14-8 옵셔널 체이닝을 통한 메서드 호출
	struct Address {    // 주소
	    var province: String        // 광역시/도
	    var city: String            // 시/군/구
	    var street: String          // 도로명
	    var building: Building?     // 건물
	    var detailAddress: String?  // 건물 외 주소
	    
	    init(province: String, city: String, street: String) {
	        self.province = province
	        self.city = city
	        self.street = street
	    }
	    
	    func fullAddress() -> String? {
	        var restAddress: String? = nil
	        
	        if let buildingInfo: Building = self.building {
	            
	            restAddress = buildingInfo.name
	            
	        } else if let detail = self.detailAddress {
	            restAddress = detail
	        }
	        
	        if let rest: String = restAddress {
	            var fullAddress: String = self.province
	            
	            fullAddress += " " + self.city
	            fullAddress += " " + self.street
	            fullAddress += " " + rest
	            
	            return fullAddress
	        } else {
	            return nil
	        }
	    }
	    
	    func printAddress() {
	        if let address: String = self.fullAddress() {
	            print(address)
	        }
	    }
	}
	
	class Person {  // 사람
	    var name: String            // 이름
	    var address: Address?       // 주소
	    
	    init(name: String) {
	        self.name = name
	    }
	}
	
	// 코드 14-5 옵셔널 체이닝의 사용
	let yagom: Person = Person(name: "yagom")
	
	// 코드 14-7 옵셔널 체이닝을 통한 값 할당
	yagom.address = Address(province: "충청북도", city: "청주시 청원구", street: "충청대로")
	yagom.address?.building = Building(name: "곰굴")
	yagom.address?.building?.room = Room(number: 0)
	yagom.address?.building?.room?.number = 505
	
	// 코드 14-8 옵셔널 체이닝을 통한 메서드 호출
	yagom.address?.fullAddress()?.isEmpty   // false
	yagom.address?.printAddress()           // 충청북도 청주시 청원구 충청대로 곰굴
		

   		
	// 코드 14-9 옵셔널 체이닝을 통한 서브스크립트 호출
	let optionalArray: [Int]? = [1, 2, 3]
	optionalArray?[1]   // 2
	
	var optionalDictionary: [String: [Int]]? = [String: [Int]]()
	optionalDictionary?["numberArray"] = optionalArray
	optionalDictionary?["numberArray"]?[2]   // 3
	
	```

### 이쯤에서 옵셔널에 대해 다시 돌아보면..  

### Q. Optionals이 왜 있을까? 왜 필요할까?
- **nil에 대한 안전한 처리**, 기본적으로 nil을 반환하는걸 막고</br>
  nil을 포함하고 싶으면 optional로 wrapped하여 사용한다.  


### Q. '옵셔널'과 '암시적 추출 옵셔널'은 대체 무슨 차이가 있고, 왜 둘 다  존재하는가?  
  > 둘 다 nil을 가질 수 있고, nil 일 때 호출해도 오류발생 안한다. 뭐가 다르지?  
  > (물론 optional은 explicitly unwarping하는 과정이 포함되어야 한다.)  


- Swift 3.1 문서상에선 nil을 가질 가능성이 있다면 Optionals쓰라고 한다.
 
  > Do not use an implicitly unwrapped optional when there is a possibility of a variable becoming nil at a later point. Always use a normal optional type if you need to check for a nil value during the lifetime of a variable.’
  >
  > 다음에서 발췌: Apple Inc. ‘The Swift Programming Language (Swift 3.1).’ iBooks. https://itun.es/kr/jEUH0.l  
  >
  > </br>
  > 또한, nil이 있을때 접근하면 error 발생한다고 되어있는데.. 뭐지..?  

  > ‘If an implicitly unwrapped optional is nil and you try to access its wrapped value, you’ll trigger a runtime error. The result is exactly the same as if you place an exclamation mark after a normal optional that does not contain a value.’
  >
  > 다음에서 발췌: Apple Inc. ‘The Swift Programming Language (Swift 3.1).’ iBooks. https://itun.es/kr/jEUH0.l


- 암시적 추출 옵셔널은 정상적인 옵셔널 체이닝이 안된다. (옵셔널 바인딩은 정상적으로 됨)  
  
  ```swift  
  // 먼저 위 예제 코드 중 address, building, room를
  // 암시적 추출 옵셔널로 선언 (선언 부분은 생략)
  
  print(jeheon.address)		// nil
  print(jeheon.address.building.room.number)		// 오류 발생!
  // nil의 프로퍼티를 접근! 당연히 런타임 에러 발생
  
  
  // 암시적 추출 옵셔널에 옵셔널 체이닝을 하면?
  // Warning 발생.. 동작 동일(?)하게 하기는 함. 
  print(jeheon.address?.building?.room?.number)	// nil
  ```
  
- 암시적 추출 옵셔널은 사용될 때에 자동으로 unwrapped되는 optional이다.  

  > ‘You can think of an implicitly unwrapped optional as giving permission for the optional to be unwrapped automatically whenever it is used.’
  > 
  > 다음에서 발췌: Apple Inc. ‘The Swift Programming Language (Swift 3.1).’ iBooks. https://itun.es/kr/jEUH0.l  


## 14.2 빠른 종료  
- **빠른종료**의 핵심 키워드는 **guard** </br>
  if 구문과는 다르게 guard 구문은 항상 else 구문이 뒤에 따라와야 한다.  

	```swift
	guard <Bool 타입 값> else {
		<예외상황 실행문>
		<제어문 전환 명령어>
	}
	```
	
	> 제어문 전환 명령어: return, break, continue, throw  
	> 또는  fatalError()와 같은 비반환 함수나 메서드를 호출할 수도 있다. 
	
- guard 구문을 사용하면 if코드를 훨씬 간결하고 읽기 좋게 구성할 수 있다.<br>
	> 라고 하는데 솔직히 '예외처리 버전의 또 다른 if'라 느껴짐 굳이 왜 만들었나..  
	> 그냥 다양한 구문이 준비되어 있으니 다양하게 같은 로직을 표현할 수 있다 정도의 이점?  

- if구문처럼 옵셔널 바인딩, 쉼표(,)로 추가조건 나열 등이 가능하다.
- 함수나 메서드 반복문 등 특정 블록 내부에 위치하지 않는다면 사용할 수 없다.