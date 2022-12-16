# FrontEnd

Sherpa의 프론트엔드 리드미 입니다.

## 화면 구성

## 공용

### Splash Screen
<img width="128" alt="image" src="https://user-images.githubusercontent.com/58414467/208084453-197d1546-15ff-4870-9ca2-85b8079b8aed.png">
어플리케이션을 처음 실행을 하게 되면 옆의 그림과 같이 splash screen이 뜨면서 실행이 될 때까지 나타나게 된다.

### 첫 시작 화면
<img width="128" alt="image" src="https://user-images.githubusercontent.com/58414467/208084599-14b56e82-e1db-4c82-b448-f803f819125b.png">
Splashscreen이 뜨고 난 후 셰르파의 첫 화면이다. 셰르파와 함께하기 버튼을 클릭하게 되면 로그인 화면으로 넘어가게 된다.

### 로그인 화면
<img width="128" alt="image" src="https://user-images.githubusercontent.com/58414467/208084824-0e102106-e967-4cfe-94e1-43005b4ce57e.png">
로그인 화면으로 들어오게 되면 다음과 같이 아이디와 비밀번호를 입력할 수 있게 된다. 만약, 아이디이와 비밀번호를 잘못 입력했을 경우 로그인에 실패하게 되며 사용자에게 다시 입력할 것을 요구한다.


## 여행객

### 여행객 메인 화면
<img width="128" alt="image" src="https://user-images.githubusercontent.com/58414467/208084942-299a452d-a6b7-440b-9017-485ec00c1802.png">
여행객의 메인화면이다. 아래에 예약하기 라는 것을 아래에서 위로 드래그를 하게 되면 출발지, 목적지, 짐 설정 및 예약 시간을 설정할 수 있다. 위쪽의 메뉴버튼을 누르게 되면 이전에 맡겼었던 짐 내역과 현재 맡긴 짐에 대한 정보를 볼 수 있는 화면으로 넘어가게 된다. 또한, 좌측상단에 있는 버튼을 누르면 운송자용으로 넘어가게 된다.

### 여행객 예약 화면
<img width="128" alt="image" src="https://user-images.githubusercontent.com/58414467/208085322-68d7137d-fae9-4099-8d87-6045c7a248a8.png">
제일 위쪽부터 차례로 출발지 및 목적지 설정, 짐 설정, 예약시간을 설정할 수 있다. 또한, 설정을 다 하게 된다면 아래쪽에 총 금액이 나오게 되고 예약하기 버튼을 눌려 짐을 예약하게 된다.

### 출발지 및 목적지 설정
<img width="128" alt="image" src="https://user-images.githubusercontent.com/58414467/208085374-f303e301-7e22-48fd-8246-4690b6797bce.png">
출발지는 자동으로 현위치를 입력받는 것으로 설정하였다. 만약, 현위치 말고 다른 곳에서 예약을 하고 싶다면 입력창에 다른 지역을 검색하여 입력하면 된다. 목적지도 이와 동일하다. 또한, 상세주소가 필요한 경우가 있다. 어느 건물 몇 동 몇호와 같이 상세 주소가 필요할 경우 아래의 상세주소란에 상세주소를 입력하면 된다. 그 후 짐 설정하기 버튼을 누르면 주소가 입력된 상태로 예약화면으로 돌아가게 된다.

### 카페 찾기 안내
<img width="128" alt="image" src="https://user-images.githubusercontent.com/58414467/208085525-75c75a25-07fc-4076-a624-fa01d4a47eea.png">
목적지를 입력하고 난 후 근처의 카페 정보를 원하는지 물어보게 된다.

### 여행객 짐 설정
<img width="128" alt="image" src="https://user-images.githubusercontent.com/58414467/208085629-1fe20c84-fb9d-4cfb-92eb-e1248293b25d.png">
짐 설정에 있는 각 짐의 버튼을 누르게 되면 이와 같은 dialog가 나오며 짐 갯수를 설정할 수 있다. 또한, 각 짐에 대한 간략한 정보가 나와 있어 사용자가 자신이 갖고 있는 짐이 소, 중, 대 중 어떤 것인지 선택할 수 있게 하였다. 이후 사용자가 완료 버튼을 누르면 해당 짐 갯수가 예약화면에서도 보이게 된다.

### 여행객 예약 시간 설정
<img width="128" alt="image" src="https://user-images.githubusercontent.com/58414467/208085797-e0706efa-aaf7-46c2-8535-898002ff7ff7.png">
출발시각과 도착시각을 설정할 수 있다. 출발 시각은 default 값으로 현재 시각이 입력되게 된다. 이렇게 출발시각과 도착시각을 지정하고 완료를 누르게 되면 예약 출발시각과 도착시각이 설정되게 된다.

### 설정 후 예약화면
<img width="128" alt="image" src="https://user-images.githubusercontent.com/58414467/208085864-ee49a730-c405-45b2-a805-6b88c35715d0.png">
설정을 다 하고 난 후 화면이다. 예약하기 버튼을 누르면 예약이 된다.

### 짐의 이동경로 안내
<img width="128" alt="image" src="https://user-images.githubusercontent.com/58414467/208085945-469784cb-c762-4971-9f8c-68fbf9668724.png">
짐을 맡기면 짐의 이동경로가 나오게 된다.

### 짐 예약 내역
<img width="128" alt="image" src="https://user-images.githubusercontent.com/58414467/208086023-ad39d926-1bae-4c91-82dd-da151ace9dd2.png">
메인 화면에서 메뉴 버튼을 누르게 되면 이전에 맡겼던 짐 내역이 나오게 되며 다음과 같이 확인할 수 있다. 이미 완료된 예약내역이라면 아래쪽에 신고하기 라는 버튼이 나오게 된다. 만약, 아직 짐이 옮겨지기 전이라면 아래에 수정하기라고 나타나게 되며 해당 예약 설정을 변경할 수 있다.

### 신고 내용
<img width="128" alt="image" src="https://user-images.githubusercontent.com/58414467/208086109-4ac449bb-2666-4734-9a8e-c80a27b38291.png">
신고하기 버튼을 누르게 되면 다음과 같이 신고 카테고리를 정할 수 있다. 만약, 짐을 도난당했다면 도난 카테고리를 눌려 상세 내용을 적으면 된다. 이러한 기능을 추가하여 사용자에게 셰르파의 신뢰도를 높이고자 하였다.


## 운송자

### 운송자 메인화면
<img width="128" alt="image" src="https://user-images.githubusercontent.com/58414467/208086243-58ed704d-2c33-4c46-b12a-b4c6cc23bec4.png">
운송자 메인화면은 여행객 메인화면과 비슷하다. 운송자의 경우 아래쪽에 예약하기가 아닌 운송하기가 나온다. 

### 운송하기 수행 시
<img width="128" alt="image" src="https://user-images.githubusercontent.com/58414467/208086533-b76b486c-0ecf-4d6e-a0d8-adc03e455804.png">
출발지와 목적지를 지정할 수 있다. 설정을 한 이후 주변 짐 찾기 버튼을 클릭하게 되면 근처에 여행객이 예약한 짐 목록이 나타나게 된다.

### 주변 짐 찾기 누를 시
<img width="128" alt="image" src="https://user-images.githubusercontent.com/58414467/208086702-c213a380-308b-4e34-8a6d-aea3dc9e52d7.png">
다음과 같이 여행객이 올려둔 예약이 나타나게 된다. 또한, 출발지와 목적지의 경로 또한 나타나게 된다.

### 여행객 예약정보 확인하기
<img width="128" alt="image" src="https://user-images.githubusercontent.com/58414467/208087283-bbdd3ef2-6517-4497-98dc-4cca8bc13995.png">
여행객의 예약을 누르게 되면 다음과 같이 예약 정보가 나타나게 된다. 출발지와 목적지, 짐 갯수, 예약 시간을 확인 할 수 있으며 배송하기 버튼을 누르면 예약을 수락하게 된다. 만약, 취소를 누르게 되면 앞의 화면으로 돌아가게 된다.

### 배송 시작 알림
<img width="128" alt="image" src="https://user-images.githubusercontent.com/58414467/208087735-be86b6af-4554-44cf-9da1-92f2b59d39a2.png">
배송하기 버튼을 누르게 되면 배송을 시작한다는 dialog가 나타나게 되며 확인을 누르면 메인화면으로 넘어가지게 된다.
