package com.himedia.springboot;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Value;

@Controller
public class OAuthController {
	
	@Value("${cos.key}")
	private String cosKey;
	
	@Autowired
	memberDAO mDao;
	//KAKAO LOGIN
	@GetMapping("/oauth/kakao")
	public String kakaoLogin(HttpServletRequest req, String code) {
		
		RestTemplate rt = new RestTemplate();
		
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
		
		MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
		params.add("grant_type", "authorization_code");
		params.add("client_id", "7fb612febcabd2e33c624c45cf59cfd5");
		params.add("redirect_uri", "http://localhost:8080/oauth/kakao");
		params.add("code", code);
		
		HttpEntity<MultiValueMap<String, String>> kakaoTokenRequest = new HttpEntity<>(params, headers);
		
		ResponseEntity<String> response = rt.exchange("https://kauth.kakao.com/oauth/token", HttpMethod.POST, kakaoTokenRequest, String.class);
		
		ObjectMapper objectMapper = new ObjectMapper();
		OAuthToken oauToken = null;
		try {
			oauToken = objectMapper.readValue(response.getBody(), OAuthToken.class);
		} catch (JsonMappingException e) {
			e.printStackTrace();
		} catch(JsonProcessingException e) {
			e.printStackTrace();
		}
		
		RestTemplate rt_ = new RestTemplate();
		
		HttpHeaders headers_ = new HttpHeaders();
		headers_.add("Authorization", "Bearer " + oauToken.getAccess_token());
		headers_.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
		
		HttpEntity<MultiValueMap<String, String>> kakaoProfileRequest = new HttpEntity<>(headers_);
		
		ResponseEntity<String> response_ = rt_.exchange("Https://kapi.kakao.com/v2/user/me", HttpMethod.POST, kakaoProfileRequest, String.class);
		
		ObjectMapper objectMapper_ = new ObjectMapper();
		
		KakaoProfile kakaoProfile = null;
		try {
			kakaoProfile = objectMapper_.readValue(response_.getBody(), KakaoProfile.class);
		} catch (JsonMappingException e) {
			e.printStackTrace();
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		
		String nickname = kakaoProfile.getProperties().getNickname();
		String email = kakaoProfile.getKakao_account().getEmail();
		String profile = kakaoProfile.getProperties().getThumbnail_image();
		
		if ( mDao.memberCheck(email) == 0 ) {
			mDao.signup(email, cosKey);
		}

		HttpSession s = req.getSession();
		s.setAttribute("profile", profile);
		s.setAttribute("nickname", nickname);
		s.setAttribute("id", email);
		
		return "redirect:/";
	}
	
}
