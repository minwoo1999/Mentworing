# MENTWORING 

![image](https://user-images.githubusercontent.com/79193811/193780638-73ffea50-a24d-47a6-9b6b-ad1f08d38c35.png)

## 프로젝트 기간

#### 2022-06 ~ 2021-11.

## 프로젝트 개요

#### 대학생분들이라면 누구나 이런 고민 한번쯤 해보셨을거라고 생각합니다.
#### 취업을 하려면 어느정도의 실력이 되야할까 ?
#### 실무에서는 어떤 업무를 할까 ?






## 프로젝트 기술 스택
* Back-end: java11,Spring boot,Mybatis3.2.2

*  Front-End:html,css,javascript

*  server:tomcat9.0,AWS EC2,ubuntu,Socket.io,AWS S3

*  Collaboration:github,eclipse

*  API: cool sms ,kg이니시스,naver mail

*  DB:oracle

* Container:Docker

* Devops:Jenkins

## 프로젝트에서 수행한 역할 및 깨달은 점

#### Sokect.io 활용한 1:1채팅서비스

* 프로젝트 기획 DB설계  backend개발을 수행하였습니다.백엔드 개발자로서 API서버 개발 및 인프라 구축을 수행하였으며, [Socket.io] 1:1   채팅구현 AWS S3 연결 및 Progress bar 구현 등등 여러가지 수행하였습니다.

#### 백엔드 API 서버 개발

* 백엔드 API서버개발은 JAVA와 Spring을 기반으로 진행하였으며, Restful api를 개발하였습니다. 또한 MVC구조로 Model View Controller   Service 구현로직을 사용하여 개발을 진행하였습니다.

#### S3 Presigned URL 도입 및 Progress bar 진행률 구현

*  파일업로드 시 AWS S3 스토리지에 객체 URL형태로 저장이되며, 대량의 파일을 업로드 시 불편함을 해소하고자, Progress bar을 구현하여    업로드 진행률을 표시해주었습니다.

#### 백엔드 아키텍처 기반 AWS 인프라 구축 및 지속적인 개선

* 백엔드 아키텍처는 미디어 중심/글로벌 서비스의 특성을 고려하여 AWS 클라우드 기반으로 설계하였으며,이를 기반으로 인프라를 구축하였습   니다.AWS EC2를 사용하여 가상인스턴스 생성 및 구축 Dockerfile을이용하여 배포를 진행하였습니다.

#### 백엔드 Mutlipart 기반 업로드 구현

* 클라이언트에서 원본 이미지, 비디오 및 파일들을 서버로 직접 올리기 때문에, 파일을 나누어 전송하는 Mutlipart 방식으로 파일 업로드를   구현하였으며, 이를 통해 서버에 한꺼번에 많은 트래픽이 가해지는 것을 방지하였습니다.

#### CI/CD 파이프라인 설정

* 프로젝트를 Docker Container와 Ec2를 이용해서 배포를 하던 도중 변경사항이 있을 경우, 지속적으로 업데이트를 해야하는 문제점을 발견하였습니다. 이러한 문제점을 해결하기위해
Jenkin의 CI/CD파이프라인을 구성하여 자동으로 빌드 및 실행까지 구성하도록하였습니다. CI/CD 방식은 Ec2에 jenkins를 올리는방식이 아닌 plain한 방식으로 window bat을 사용하여
jenkins를 구성하였습니다.



## 시연영상

해당링크를 통해 확인하세요.
https://infruntest.s3.ap-northeast-2.amazonaws.com/infrun.mp4
