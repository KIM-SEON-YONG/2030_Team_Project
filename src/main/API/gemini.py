import pathlib
import textwrap

import google.generativeai as genai

# from IPython.display import display 주피터, IPython 쉘 안에서 그래프 시각화, HTML/이미지 출력을 하기 위해 필요한 기능 - 우린 필요 없음
# from IPython.display import Markdown 주피터의 텍스트 꾸미는 라이브러리
from api_key import Config

# 서식이 지정된 Markdown 텍스트를 표시하는 함수
def to_markdown(text):
  text = text.replace('•', '  *')
  return Markdown(textwrap.indent(text, '> ', predicate=lambda _: True))



# 제미나이 API 키 설정
genai.configure(api_key=Config.GOOGLE_API_KEY)
model = genai.GenerativeModel('gemini-pro')

# response = model.generate_content('목포에서 출산 시 복지 정책을 알려줘')
# print('\n\n', response.text)


chat = model.start_chat(history=[]) # 메모리 기능 설정
while True: 
    message = input(f'\n\n질문: ')
    if message == 'exit':
        break
    """ elif message == '목포시 결혼정책':
       response = '메뉴 중 "결혼"을 클릭하고 지역을 선택하여 확인하세요!' """

    response = chat.send_message(message)
    print(f'''\n\n답변: {response.text}\n\n''')
   