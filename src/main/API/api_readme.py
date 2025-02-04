""" 
새터미널 열었을 경우 아래 작업을 진행하여야 챗봇이 작동함

<vscode 가상환경 접근 및 ai 설치, py 파일 확인>
터미널 열기 단축키: ctrl + ~
*참고: 해당 루틴은 새 터미널마다 해야된다
*참고: pip 는 해당 프로젝트 어느폴더에 있어도 됨(but 경로를 이용해서 파일을 실행하는 경우는 제외)
*참고: ex)test.py 실행 후 강제종료하려면 ctrl+c 

	1) Set-ExecutionPolicy RemoteSigned -Scope Process # 정책변경코드: -Scope Process 는 현재 프로세스(세션)에만 적용되고 ,이창을 닫으면 원래 정책으로 돌아감, RemoteSigned는 인터넷에서 다운로드한 스크립트는 서명이 필요하지만 로컬에서 생성한 스크립트는 서명없어도 실행 가능
    1_2) + 처음 실행하는 사람은 해야할일 : 가상환경 생성
          -  python -m venv venv
	2) .\venv\Scripts\Activate.ps1 실행(PowerShell환경에서는 activate.ps1 을 쓰는 편이 정석)
	
	3) pip install --upgrade google-generativeai
 	    pip install --upgrade absl-py grpcio # gemini 실행 종료 시 warning ~~befor absl~~ 뜨길래 업데이트 실행
	    pip install flask

        pip install cx_Oracle => 먼저! cx_Oracle 설치! 
         
          
            (1) https://visualstudio.microsoft.com/ko/visual-cpp-build-tools/ > Build Tools 다운로드
            (2) 설치 > C++ Build Tools 항목 선택 후 설치
            (3) pip install cx_Oracle

            +빌드된 바이너리 파일을 설치하는 방법도 있음(libs> .whl)
            하지만 cp10으로 파이썬 버전도 3.10이 되어야함
            현재 파이썬 버전이 3.12.7 이므로 사용하려면 파이썬버전을 낮춰야함
            방법)
            (1) https://www.python.org/downloads/ 3.10 다운
            (2) 새로운 파이썬 버전에서 cx_Oracle 설치
                python -m pip install cx_Oracle

	4) 원하는 작업 진행
	cd C:\Users\user\git\2030_Team_Project\src\main\API
    python app.py 실행

- 해당 폴더로 이동하는 방법: cd C:\Users\user\git\2030_Team_Project\src\main\API
					python app.py 실행
-(상대경로) 경로 직접 지정해 실행: python src\main\webapp\API\test.py

""" 