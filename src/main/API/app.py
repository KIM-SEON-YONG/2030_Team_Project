# flask란?
# flask 는 HTTP 요청을 받아들이고, 그 요청에 대한 적절한 응답(ex. JSON형식의 데이터)을
# 생성해 주는 경량 웹 서버 역활을 함
# 이로인해 Python으로 작성한 API 엔드포인트를 외부(이클립스)에서 
# HTTP 프로토콜을 통해 호출할 수 있다
# Python API 환경을 구축하기 위해 Flask는 필수는 아니지만,
# 빠르고 효율적으로 API 서버를 만들 수 있도록 도와주는 매우 유용한 도구

import google.generativeai as genai
import re # 정규 표현식 모듈 임포트

from api_key import Config
from flask import Flask, request, jsonify
from api_db import get_policyList, get_regions # api_db.py에서 함수 불러오기

app = Flask(__name__)

# Google Gemini API 키 설정
genai.configure(api_key=Config.GOOGLE_API_KEY)

# Gemini AI 모델 로드
model = genai.GenerativeModel('gemini-pro')
chat = model.start_chat(history=[]) # 대화 기록 유지

# 지역명과 복지 분류를 추출하는 함수
def extract_region_and_welfare_category(user_input):
    # 지역명 리스트(전라남도)
    regions = get_regions() # 이 함수는 api_db에서 가져온 지역 리스트를 반환환

    welfare_categories = ["취업", "결혼", "출산"]

    # 지역과 복지 분류 추출 (지역, 복지가 여러개일 수 있으므로 리스트 형식)
    region = []
    welfare_category = []

    print("DB지역리스트:", ",".join(regions))

    # 사용자가 입력한 지역이 regions 배열 안에 있는지
    for r in regions:
        if r in user_input:
            region.append(r)
    
    # "모든지역", "모든 지역" 이라는 문구가 있을 경우 region 값에 
    # DB에 있는 모든 지역의 값을 넣어주기!
    if "모든 지역" in user_input or "모든지역" in user_input:
        region = regions # DB에서 가져온 모든 지역을 region에 넣음

    # 복지 분류 찾기
    for wc in welfare_categories:
        if wc in user_input:
            welfare_category.append(wc)
    
    print("사용자가 입력한 지역: ", ",".join(region))
    print("사용자가 입력한 복지: ", ",".join(welfare_category))
    return region, welfare_category

@app.route('/api/chatbot', methods=['POST']) # /api/chatbot 경로로 post요청이 오면 처리
def chatbot():

    # 클라이언트(자바 측)에서 보낸 JSON 데이터 받기
    user_input = request.json.get('message', '').strip() # strip: 문자열의 양쪽 끝 공백 제거

    # 입력값에 대한 조건 처리
    if user_input == '종료!':
        return jsonify({"answer": "챗봇을 종료합니다."})
    
    if re.match(r'^[0-9]+$', user_input):  # 숫자만 입력되면
        return jsonify({"answer": "숫자만 입력할 수 없습니다. 질문을 다시 입력해 주세요."})
    
    if not user_input:  # 빈 입력인 경우 - 근데 이건 이미 이클립스에서 alert창으로 처리중
        return jsonify({"answer": "입력값이 없습니다. 질문을 입력해 주세요."})

    if re.match(r'^[0-9!@#$%^&*(),.?":{}|<>]+$', user_input):  # 특수 문자만 있을 경우
        return jsonify({"answer": "유효하지 않은 문자가 포함되어 있습니다."})

    # 특수 문자만 포함된 경우에만 유효하지 않다고 판단하도록 수정
    # 만약 정보를 제공해야하는 질문을 했는데도 "유효하지 않은 문자가 포함되어 있습니다."
    # 라고 답변을하면 해당 if문을 삭제하고 아래 if문 활성화
    """ if re.match(r'^[^a-zA-Z0-9가-힣\s]+$', user_input):  # 한글, 숫자, 알파벳, 공백을 제외한 문자만 있을 경우
        return jsonify({"answer": "유효하지 않은 문자가 포함되어 있습니다."}) """
    
    # 지역명과 복지 분류 추출
    region, welfare_category = extract_region_and_welfare_category(user_input)

    # DB에서 해당 지역과 복지 분류에 맞는 정책 조회
    query_result = get_policyList(region, welfare_category)
    
    # 반환값이 문자열인 경우(지역,복지 조건이 없어서 전라남도 지역에 대한 문구가 반환된 경우)
    if isinstance(query_result, str):
        return jsonify({"answer": query_result})

    if query_result:
        # DB 결과가 있으면 해당 정보를 반환
        response = f"{', '.join(region) if region else '전체 지역'}의 {', '.join(welfare_category) if welfare_category else '전체 복지'} 관련 정책입니다.\n\n"
        for row in query_result:
            response += f"제목: {row[0]}\n, 내용: {row[1]}\n, 기간: {row[2]}\n, URL: {row[3]}\n\n"
        return jsonify({"answer": response})
   
    # DB에 해당 자료가 없으면, AI 모델을 사용하여 답변 생성 => 챗봇 대답 안하게 조치
    """ response = "현재 웹사이트에는 원하시는 요청에 대한 정보가 없습니다. GPT를 사용한 답변입니다." 
    response_chatbot = chat.send_message(user_input)
    response_text = response + "\n\n" + response_chatbot.text  # 두 개의 응답을 먼저 합친 후에 JSON으로 반환
    return jsonify({"answer": response_text}) """

if __name__ == '__main__':
    # Flask 서버 실행(기본 포트는 5000)
    app.run(port=5000)



