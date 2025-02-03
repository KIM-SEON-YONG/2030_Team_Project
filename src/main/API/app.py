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

app = Flask(__name__)

# Google Gemini API 키 설정
genai.configure(api_key=Config.GOOGLE_API_KEY)

# Gemini AI 모델 로드
model = genai.GenerativeModel('gemini-pro')
chat = model.start_chat(history=[]) # 대화 기록 유지

@app.route('/api/chatbot', methods=['POST']) # /api/chatbot 경로로 post요청이 오면 처리
def chatbot():
    global last_input_time, timer

    # 클라이언트(자바 측)에서 보낸 JSON 데이터 받기
    user_input = request.json.get('message', '').strip() # strip: 문자열의 양쪽 끝 공백 제거

    # 입력값에 대한 조건
    if user_input == '종료!':
        return jsonify({"answer": "챗봇을 종료합니다."})
    
    if re.match(r'^[0-9]+$', user_input):  # 숫자만 입력되면
        return jsonify({"answer": "숫자만 입력할 수 없습니다. 질문을 다시 입력해 주세요."})
    
    if not user_input:  # 빈 입력인 경우 - 근데 이건 이미 이클립스에서 alert창으로 처리중
        return jsonify({"answer": "입력값이 없습니다. 질문을 입력해 주세요."})

    if re.match(r'^[^a-zA-Z0-9\s]+$', user_input):  # 특수 문자만 있을 경우
        return jsonify({"answer": "유효하지 않은 문자가 포함되어 있습니다."})

    # 특수 문자만 포함된 경우에만 유효하지 않다고 판단하도록 수정
    # 만약 정보를 제공해야하는 질문을 했는데도 "유효하지 않은 문자가 포함되어 있습니다."
    # 라고 답변을하면 해당 if문을 삭제하고 아래 if문 활성화
    """ if re.match(r'^[^a-zA-Z0-9가-힣\s]+$', user_input):  # 한글, 숫자, 알파벳, 공백을 제외한 문자만 있을 경우
        return jsonify({"answer": "유효하지 않은 문자가 포함되어 있습니다."}) """

    # AI 모델에게 질문 보내고 응답 받기
    response_chatbot = chat.send_message(user_input)
    # response_text = f"Python 챗봇이 받은 메시지: {user_input}"

    # JSON 형태로 응답 반환
    return jsonify ({"answer": response_chatbot.text})
    # return jsonify ({"answer": response_text})

if __name__ == '__main__':
    # Flask 서버 실행(기본 포트는 5000)
    app.run(port=5000)



