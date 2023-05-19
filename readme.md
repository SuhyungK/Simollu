## Simollu


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

