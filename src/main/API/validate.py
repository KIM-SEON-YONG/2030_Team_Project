import re

def validate_input(user_input):
    # 정규 표현식: 숫자만 있는 입력은 유효하지 않다고 판단
    if re.match(r'^[0-9]+$', user_input):  # 숫자만 있을 경우
        return False
    
    # 유효한 입력 반환
    return True

# 테스트
user_input = "ddd"
if validate_input(user_input):
    print("유효한 입력입니다.")
else:
    print("잘못된 입력입니다.")
