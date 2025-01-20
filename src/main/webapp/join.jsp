<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
    table {
        width: 600px;
        height: 500px;
        margin: auto;
        font-size: 15px;
        background-color: #f0f0f0;
        border-radius: 20%;
        text-align: left; /* 기존 입력 필드 정렬 유지 */
    }

    tr > td:first-child {
        text-align: right; /* 라벨 텍스트 오른쪽 정렬 */
        padding-right: 20px;
    }
        
    input[type="text"], input[type="password"] {
        width: 250px;
        height: 32px;
        font-size: 15px;
        border: 0;
        border-radius: 15px;
        outline: none;
        padding-left: 10px;
        background-color: rgb(233, 233, 233);
        margin: 5px 0; /* 위아래 간격 */
    }

    .btn {
        width: 100px;
        height: 32px;
        font-size: 20px;
        border: 0;
        border-radius: 15px;
        outline: none;
        background-color: rgb(233, 233, 233);
    }

    .btn:active {
        background-color: rgb(61, 135, 255);
    }

    .button-container {
        display: flex;
        justify-content: center; /* 버튼 중앙 정렬 */
        align-items: center;    /* 세로 중앙 정렬 */
        gap: 20px;              /* 버튼 간격 */
        margin-top: 20px;
    }
    
    .inputtag{
       width: 400px;
    }
</style>

</head>
<body>
   <h2 style="text-align: center;">회원가입</h2>
   <form action="login(실험).jsp">
   <table>
      <tr>
         <td></td>
         <td class="inputtag"><input type="text" name="USER_NAME" size="20" placeholder="이름"></td>
      </tr>
      <tr>
         <td></td>
         <td class="inputtag">
            <input type="radio" name="USER_GENDER" value="남자" checked="checked">남자
            <input type="radio" name="USER_GENDER" value="여자">여자
         </td>   
      </tr>
      <tr>
         <td></td>
         <td class="inputtag"><input type="text" name="USER_BIRTHDATE" size="20" placeholder="생년월일"></td>
      </tr>   
      <tr>
         <td></td>
         <td class="inputtag"><input type="text" name="USER_ID" size="20" id="userid" placeholder="아이디">
            <input type="hidden" name="reid" size="20"> 
            <input type="button" value="중복체크" onclick="idCheck()"></td>
      </tr>
      <tr>
         <td></td>
         <td class="inputtag"><input type="password" name="USER_PW" size="20" placeholder="비밀번호"></td>
      </tr>
      <tr>
         <td></td>
         <td class="inputtag"><input type="password" name="pw_check" size="20" placeholder="비밀번호재확인"></td>
      </tr>
      <tr>
         <td></td>
         <td class="inputtag"><input type="text" name="USER_PHONE" size="20" placeholder="전화번호"></td>
      </tr>   
      <tr>
         <td></td>
         <td class="inputtag"><input type="text" name="FAV_WELFARE" size="20" placeholder="관심분야"></td>
      </tr>
      <tr>
         <td></td>
         <td class="inputtag"><input type="text" name="FAV_REGION" size="20" placeholder="관심지역"></td>
      </tr>
      <tr>
    <td colspan="2" style="padding-bottom: 20px;">
        <div class="button-container">
            <input type="submit" class="btn" value="확인" onclick="return joinCheck()">
            <input type="reset" class="btn" value="취소">
        </div>
    </td>
</tr>
    
   </table>
   </form>
</body>
</html>