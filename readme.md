## Simollu





waiting-service

식당 대기와 관련된 작업을 수행합니다.

대기 신청, 대기 조회, 내역 조회, 미루기 기능 등의 행동을 합니다.

실시간 순위 정보를 redis 기록해 사용자들에게 현재 순위와 예상 대기 시간을 제공합니다. 


restaurant-service
식당, 후기 관련 기능을 담당하는 restaurant service 입니다.
엘라스틱 서치와 연결하여 검색을 구현했습니다.


user-service
카카오 소셜 로그인, 로그아웃 
회원의 기본 정보와 닉네임, 프로필 이미지, 포크, 상태 등을 관리합니다.


discovery-service
port : 8761
마이크로서비들의 이름과 ip address, port 번호를 관리하는 서비스 입니다.
이곳에 마이크로서비스들이 자신의 ip address, port 번호를 등록하면 Spring Cloud Gateway가 참고해서 경로를 지정해줍니다. 


Config-service
서비스들의 설정 정보를 관리하고 연결시켜 줍니다. 
bootstrap.yml, Docker 파일은 서버 안에서 관리합니다.
application.yml 파일은 다른 gitlab 저장소에 있습니다.
https://lab.ssafy.com/cladren12332/simollu_config



api gateway
spring cloud gateway로 구현했습니다.
discovery-service를 통해 각각의 서비스들의 이름과 ip address, port를 확인합니다.
그 이후 요청에 맞는 알맞은 경로를 설정해 줍니다.
jwt 토큰의 유효성 검증 필터를 적용합니다.





