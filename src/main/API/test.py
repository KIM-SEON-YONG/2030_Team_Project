import google.generativeai as genai
import api_key

GOOGLE_API_KEY = 'AIzaSyBb-p2enmgQr3yuR9U84if_IJb0Xst78mU'
genai.configure(api_key=GOOGLE_API_KEY)
model = genai.GenerativeModel('gemini-pro')

chat = model.start_chat(history=[]) # 메모리 기능 설정
while True: 
    message = input(f'\n\n질문: ')
    if message == 'exit':
        break

    response = chat.send_message(message)
    print(f'''\n\n답변: {response.text}\n\n''')
    


