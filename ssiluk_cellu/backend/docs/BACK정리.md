# 서버 아키텍처

- 플랫폼
  - Node.js, Express.js
- 호스팅
  - AWS EC2(ubuntu 20.04)
- 프로세스 관리
  - PM2

## 주요 기능 및 컴포넌트

- 구조
  - RESTful API 구조, 컨트롤러 및 라우터의 모듈화
-
- 주요 컴포넌트

  - Express.js - 웹 프레임워크 (웹 서버 및 라우팅)
  - Passport.js - OAuth 기반의 소셜 로그인 인증
  - Winston - 로그 관리
  - Multer - 이미지 업로드 및 관리
  - Twilio - SMS 알림 서비스
  - AWS SDK - S3 이미지 업로드 및 관리
  - JWT - 사용자 인증 및 보안

- 실행환경
  - PM2를 사용한 Node.js 프로세스의 백그라운드 관리

# 데이터베이스 설계

- DBMS

  - MYSQL

- 구조

  - 관계형 데이터베이스 스키마

- 주요 테이블

  - 사용자(User): 이메일, 소셜 로그인 타입, 기타 개인 정보
  - 복약(Dose): 복약 시간, 약 이름, 복용량
  - 식단(Diet): 식사 내용, 시간, 이미지 URL
  - 체중(Weight): 체중 기록
  - 센서 데이터(Sensor): 생체 신호, 스트레스 수준
  - 보호자(Guardian): 사용자의 보호자 관리

- 테이블 설계
  - 사용자 정보, 복약 정보, 식단 기록, 체중 기록, 센서 데이터, 보호자 등
  - 각 테이블은 모델화되어 CRUD 작업 수행
- 보안
  - 환경 변수를 통한 데이터베이스 접속 정보 관리
  - 사용자 비밀번호 SHA2 암호화 알고리즘 사용

# API 및 데이터 처리

- API 엔드포인드

  - 사용자 인증: 로그인, 로그아웃, 소셜 로그인
  - 복약 관리: 복약 기록 추가, 조회, 삭제
  - 식단 관리: 식단 기록 추가, 조회, 수정, 삭제
  - 체중 관리: 체중 기록 추가, 조회, 삭제
  - 센서 데이터: 스트레스 레벨 조회
  - 보호자 관리: 보호자 이름, 전화번호, 관계 등 보호자 정보 추가, 조회, 수정, 삭제

- 데이터 처리
  - CRUD 작업
    - MYSQL 데이터베이스를 통해 데이터 저장, 조회, 수정, 삭제
  - 파일 처리
    - Multer와 AWS S3를 통한 이미지 파일 업로드 및 관리

# 보안 및 성능 최적화

- 보안
  - JWT 기반 인증
  - 환경 변수 관리
- 성능 최적화
  - PM2를 통한 프로세스 관리 및 로드 밸런싱
  - 데이터베이스 쿼리 최적화
  - 비동기 처리 및 에러 핸들링

# 시각적 자료

- 서버 아키텍쳐 다이어그램

  ```mermaid
  graph LR
    A[Express.js App] -->|Middleware| B[Passport.js]
    A -->|Middleware| C[Winston Logger]
    A -->|Middleware| D[Multer for Image Upload]
    A -->|API Routes| E[User]
    A -->|API Routes| F[Dose]
    A -->|API Routes| G[Diet]
    A -->|API Routes| H[Weight]
    A -->|API Routes| I[Sensor]
    A -->|API Routes| J[Guardian]

    E -->|CRUD| K[MySQL Database]
    F -->|CRUD| K
    G -->|CRUD| K
    H -->|CRUD| K
    I -->|CRUD| K
    J -->|CRUD| K

    E -->|OAuth| L[Google]
    E -->|SMS Alerts| M[Twilio]
    G -->|Image Storage| N[AWS S3]

    style A fill:#f9f,stroke:#333,stroke-width:2px
    style K fill:#ff9,stroke:#333,stroke-width:2px
    style L fill:#f96,stroke:#333,stroke-width:2px
    style M fill:#9f9,stroke:#333,stroke-width:2px
    style N fill:#696,stroke:#333,stroke-width:2px
    style B fill:#ffffff,stroke:#333,stroke-width:2px
    style C fill:#ffffff,stroke:#333,stroke-width:2px
    style D fill:#ffffff,stroke:#333,stroke-width:2px
    style E fill:#ffffff,stroke:#333,stroke-width:2px
    style F fill:#ffffff,stroke:#333,stroke-width:2px
    style G fill:#ffffff,stroke:#333,stroke-width:2px
    style H fill:#ffffff,stroke:#333,stroke-width:2px
    style I fill:#ffffff,stroke:#333,stroke-width:2px
    style J fill:#ffffff,stroke:#333,stroke-width:2px
  ```

- 데이터베이스 스키마 다이어그램

  ```mermaid
  erDiagram
    USER ||--o{ DOSE : has
    USER ||--o{ DIET : tracks
    USER ||--o{ WEIGHT : records
    USER ||--o{ SENSOR : provides
    USER ||--o{ GUARDIAN : assigns

    USER {
        string id PK
        string name
        string email
        string socialLoginType
    }

    DOSE {
        int id PK
        string medicine
        string amount
        datetime time
        string type
    }

    DIET {
        int id PK
        datetime time
        string content
        string image
    }

    WEIGHT {
        int id PK
        float value
        datetime date
    }

    SENSOR {
        int id PK
        string type
        string data
        datetime timestamp
    }

    GUARDIAN {
        int id PK
        string name
        string phone
        string relationship
    }
  ```

- API 엔드포인트 리스트

  ```mermaid
  graph LR
    style A fill:#f9f,stroke:#333,stroke-width:2px
    A[Express.js Server] -->|User Management| B[User API]
    A -->|Medication Tracking| C[Dose API]
    A -->|Dietary Records| D[Diet API]
    A -->|Weight Tracking| E[Weight API]
    A -->|Sensor Data| F[Sensor API]
    A -->|Guardian Management| G[Guardian API]

    style B fill:#f96,stroke:#333,stroke-width:4px
    style C fill:#f96,stroke:#333,stroke-width:4px
    style D fill:#f96,stroke:#333,stroke-width:4px
    style E fill:#f96,stroke:#333,stroke-width:4px
    style F fill:#f96,stroke:#333,stroke-width:4px
    style G fill:#f96,stroke:#333,stroke-width:4px

    B --> B1["/user/signup POST"]
    B --> B2["/user/login POST"]
    B --> B3["/user/profile GET"]
    B --> B4["/user/profile PUT"]
    B --> B5["/user/logout POST"]

    C --> C1["/dose POST"]
    C --> C2["/dose GET"]
    C --> C3["/dose/{id} DELETE"]

    D --> D1["/diet POST"]
    D --> D2["/diet GET"]
    D --> D3["/diet/{id} PUT"]
    D --> D4["/diet/{id} DELETE"]

    E --> E1["/weight POST"]
    E --> E2["/weight GET"]
    E --> E3["/weight/{id} DELETE"]

    F --> F1["/sensor/data GET"]

    G --> G1["/guardian POST"]
    G --> G2["/guardian GET"]
    G --> G3["/guardian PUT"]
    G --> G4["/guardian DELETE"]

    style B1 fill:#ff9,stroke:#333,stroke-width:2px
    style B2 fill:#ff9,stroke:#333,stroke-width:2px
    style B3 fill:#ff9,stroke:#333,stroke-width:2px
    style B4 fill:#ff9,stroke:#333,stroke-width:2px
    style B5 fill:#ff9,stroke:#333,stroke-width:2px
    style C1 fill:#ff9,stroke:#333,stroke-width:2px
    style C2 fill:#ff9,stroke:#333,stroke-width:2px
    style C3 fill:#ff9,stroke:#333,stroke-width:2px
    style D1 fill:#ff9,stroke:#333,stroke-width:2px
    style D2 fill:#ff9,stroke:#333,stroke-width:2px
    style D3 fill:#ff9,stroke:#333,stroke-width:2px
    style D4 fill:#ff9,stroke:#333,stroke-width:2px
    style E1 fill:#ff9,stroke:#333,stroke-width:2px
    style E2 fill:#ff9,stroke:#333,stroke-width:2px
    style E3 fill:#ff9,stroke:#333,stroke-width:2px
    style F1 fill:#ff9,stroke:#333,stroke-width:2px
    style G1 fill:#ff9,stroke:#333,stroke-width:2px
    style G2 fill:#ff9,stroke:#333,stroke-width:2px
    style G3 fill:#ff9,stroke:#333,stroke-width:2px
    style G4 fill:#ff9,stroke:#333,stroke-width:2px
  ```
