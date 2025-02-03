package external;

import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.Map;

import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;

import com.fasterxml.jackson.databind.ObjectMapper;

public class ChatbotApiCaller {

	public static void main(String[] args) {
		// Java(이클립스)에서 Python API를 호출할 때는 일반적으로 HTTP 클라이언트 라이브러리(예: Apache HttpClient 등)를 사용
		
		// Flask 서버 주소
        String url = "http://127.0.0.1:5000/api/chatbot";

        // 전송할 JSON 데이터 (예: {"message":"안녕하세요"})
        Map<String, String> requestBody = new HashMap<>();
        requestBody.put("message", "안녕하세요?");

        // Jackson 등으로 Map -> JSON 문자열 변환
        ObjectMapper mapper = new ObjectMapper();
        try {
            String jsonString = mapper.writeValueAsString(requestBody);

            // HttpClient 객체 생성
            try (CloseableHttpClient httpClient = HttpClients.createDefault()) {
                // POST 요청 생성
                HttpPost postRequest = new HttpPost(url);

                // JSON을 Request Body로 담기
                StringEntity entity = new StringEntity(jsonString, StandardCharsets.UTF_8);
                postRequest.setEntity(entity);
                
                // 헤더 설정
                postRequest.setHeader("Content-Type", "application/json");

                // 요청 실행
                try (CloseableHttpResponse response = httpClient.execute(postRequest)) {
                    int statusCode = response.getStatusLine().getStatusCode();
                    HttpEntity respEntity = response.getEntity();
                    String respBody = (respEntity != null) 
                            ? EntityUtils.toString(respEntity, StandardCharsets.UTF_8) 
                            : null;

                    System.out.println("HTTP Status: " + statusCode);
                    System.out.println("Response Body: " + respBody);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            
        }

	}

}
