package com.EZ.ajax.basic;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.EZ.ajax.domain.UserVO;

@Controller
@RequestMapping("/ajax")

public class AjaxController {
	@RequestMapping("/example")
	public String showExamplePage() {
		return "ajax/example";
	}

//	jsp---> Controller
	@ResponseBody
	@RequestMapping("/javascript")
	public void javascriptAjax(String msg) {
		System.out.print("전송받은 메시지: " + msg);
	}

//	Controller ---> jsp
	// View Resolver 가지 않기 위해 ResponseBody
	@ResponseBody
	@RequestMapping("/sendMsg")
	public String sendToClient() {
		return "hello";
	}

// 서로 보내고 받기 
	@ResponseBody
	@RequestMapping("/sendAndRecv")
	public String sendValProcessing(Integer num1, Integer num2) {
		int result = num1 + num2;
		return result + "";
		// Integer result = num1 + num2;
		// return String.valueOf(result);
	}

	@ResponseBody
	@RequestMapping(value="/sendAndJson"
	,produces="application/json;charset=utf-8")
	public String jsonProcessing(String userId) {
		List<UserVO> userList = new ArrayList<UserVO>();
		userList.add(new UserVO("khuser01", "pass01"));
		userList.add(new UserVO("khuser02", "pass02"));
		userList.add(new UserVO("khuser03", "pass03"));
		userList.add(new UserVO("khuser04", "pass04"));
		userList.add(new UserVO("khuser05", "pass05"));
		UserVO findOne = null;
		for (UserVO uOne : userList) {
			if (uOne.getUserId().equals(userId)) {
				findOne = uOne;
				break;
			}
		}
//	USERVO 를 JSON 으로 변경 해서 전송 ajax 가 그대로 받지 못해서 변경 , pom.xml에 작성 해줘야함
	//userToJson
		JSONObject json = new JSONObject();
		json.put("userId", findOne.getUserId());
		json.put("userPw", findOne.getUserPw());
		return json.toString();
	}
// user TO Json   ---> user To Map 으로 해보기
	@ResponseBody
	@RequestMapping(value="/sendAndJsonMap")
	public Map<String , Object> jsonMapProcessing(String userId) {
		List<UserVO> userList = new ArrayList<UserVO>();
		userList.add(new UserVO("khuser01", "pass01"));
		userList.add(new UserVO("khuser02", "pass02"));
		userList.add(new UserVO("khuser03", "pass03"));
		userList.add(new UserVO("khuser04", "pass04"));
		userList.add(new UserVO("khuser05", "pass05"));
		UserVO findOne = null;
		for (UserVO uOne : userList) {
			if (uOne.getUserId().equals(userId)) {
				findOne = uOne;
				break;
			}
		}
		//userTOMap
		Map<String , Object> userMap = new HashMap<String,Object>();
		userMap.put("userId", findOne.getUserId());
		userMap.put("userPw", findOne.getUserPw());
	
		return userMap;
	}
	@ResponseBody
	@RequestMapping(value="/sendAndJsonJackson")
	public UserVO jsonJacksonProcessing(String userId) {
		List<UserVO> userList = new ArrayList<UserVO>();
		userList.add(new UserVO("khuser01", "pass01"));
		userList.add(new UserVO("khuser02", "pass02"));
		userList.add(new UserVO("khuser03", "pass03"));
		userList.add(new UserVO("khuser04", "pass04"));
		userList.add(new UserVO("khuser05", "pass05"));
		UserVO findOne = null;
		for (UserVO uOne : userList) {
			if (uOne.getUserId().equals(userId)) {
				findOne = uOne;
				break;
			}
		}
		return findOne;
	}
	@ResponseBody
	@RequestMapping(value="/sendAndJsonList")
	public String jsonList(String userId) {
		List<UserVO> userList = new ArrayList<UserVO>();
		userList.add(new UserVO("khuser01", "pass01"));
		userList.add(new UserVO("khuser02", "pass02"));
		userList.add(new UserVO("khuser03", "pass03"));
		userList.add(new UserVO("khuser04", "pass04"));
		userList.add(new UserVO("khuser05", "pass05"));
		UserVO findOne = null;
		// 아이디가 보낸 값이랑 맞는지 확인
		for(UserVO uOne: userList) {
			if(uOne.getUserId().equals(userId)) {
				findOne=uOne;
				break;
			}
		}
		
//		유저 아이디를 보내서 해당 유저를 가져오기
		JSONArray jsonArr = new JSONArray();
		if(findOne !=null) {
			JSONObject json = new JSONObject();
			json.put("userId", findOne.getUserId());
			json.put("userPw", findOne.getUserPw());
			jsonArr.add(json);
		}else {
			// 없는 경우 전체 리스트 가져오기
			for(UserVO user: userList) {
				JSONObject json = new JSONObject();
				json.put("userId", user.getUserId());
				json.put("userPw", user.getUserPw());				
				jsonArr.add(json);
			}
		}
		return jsonArr.toString();
		
	}
	
}