package com.spring.board.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Spliterator;
import java.util.Stack;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.board.HomeController;
import com.spring.board.service.boardService;
import com.spring.board.vo.BoardVo;
import com.spring.board.vo.ComCodeVo;
import com.spring.board.vo.PageVo;
import com.spring.board.vo.UserInfoVo;
import com.spring.common.CommonUtil;

@Controller
public class BoardController {

	@Autowired
	boardService boardService;

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	@RequestMapping(value = "/board/boardList.do", method = RequestMethod.GET)
	public String boardList(Locale locale, Model model, PageVo pageVo, HttpSession session) throws Exception {

		List<BoardVo> boardList = new ArrayList<BoardVo>();
		List<ComCodeVo> codeList = new ArrayList<ComCodeVo>();

		int page = 1;
		int totalCnt = 0;

		if (pageVo.getPageNo() == 0) {
			pageVo.setPageNo(page);
			;
		}

		ComCodeVo codeVo = new ComCodeVo();
		codeVo.setCodeType("menu");

		totalCnt = boardService.selectBoardCnt();
		codeList = boardService.selectCodeList(codeVo);
//		System.out.println("codeList>>>>>>>>>>>" + codeList);
		/*
		 * codeList>>>>>>>>>>> [ComCodeVo [codeType=menu, codeId=a01, codeName=�Ϲ�,
		 * creator=null, modifier=null], ComCodeVo [codeType=menu, codeId=a02,
		 * codeName=Q&A, creator=null, modifier=null], ComCodeVo [codeType=menu,
		 * codeId=a03, codeName=�͸�, creator=null, modifier=null], ComCodeVo
		 * [codeType=menu, codeId=a04, codeName=����, creator=null, modifier=null]]
		 */

		List<String> codeIdList = new ArrayList<>();
		for (ComCodeVo comCode : codeList) {
			codeIdList.add(comCode.getCodeId());
		}
		;
		pageVo.setCodeId(codeIdList);
		boardList = boardService.SelectBoardList(pageVo);

		UserInfoVo loginUser = (UserInfoVo) session.getAttribute("loginUser");
		System.out.println("session���� ������ userVo >>> " + loginUser);

		model.addAttribute("boardList", boardList);
		model.addAttribute("codeList", codeList);
		model.addAttribute("totalCnt", totalCnt);
		model.addAttribute("pageNo", page);
		model.addAttribute("loginUser", loginUser);

		return "board/boardList";
	}

	@RequestMapping(value = "/board/{boardType}/{boardNum}/boardView.do", method = RequestMethod.GET)
	public String boardView(Locale locale, Model model, HttpSession session,
			@PathVariable("boardType") String boardType, @PathVariable("boardNum") int boardNum) throws Exception {

		BoardVo boardVo = new BoardVo();

		boardVo = boardService.selectBoard(boardType, boardNum);

		UserInfoVo userVo = (UserInfoVo) session.getAttribute("loginUser");

		model.addAttribute("boardType", boardType);
		model.addAttribute("boardNum", boardNum);
		model.addAttribute("board", boardVo);
		model.addAttribute("loginUser", userVo);

		return "board/boardView";
	}

	@RequestMapping(value = "/board/boardWrite.do", method = RequestMethod.GET)
	public String boardWrite(Locale locale, Model model, ComCodeVo codeVo, HttpSession session) throws Exception {

		List<ComCodeVo> codeList = new ArrayList<ComCodeVo>();

		codeVo.setCodeType("mbti");
		codeList = boardService.selectCodeList(codeVo);

		UserInfoVo loginUser = (UserInfoVo) session.getAttribute("loginUser");

		model.addAttribute("codeList", codeList);
		model.addAttribute("loginUser", loginUser);

		return "board/boardWrite";
	}

	/*
	 * @RequestMapping(value = "/board/boardWriteAction.do", method =
	 * RequestMethod.POST)
	 * 
	 * @ResponseBody // @Transactional //�ǳ�.? public String boardWriteAction(Locale
	 * locale, @RequestBody List<?> boardData) throws Exception{
	 * 
	 * System.out.println("���� �Խñ� board >>>>>>>>>>>>>>>>> " + boardData.toString());
	 * System.out.println("���� �Խñ� board >>>>>>>>>>>>>>>>> " + boardData.size());
	 * 
	 * HashMap<String, String> result = new HashMap<String, String>(); CommonUtil
	 * commonUtil = new CommonUtil(); int resultCnt = -1;
	 * 
	 * //class java.lang.Integer cannot be cast to class java.lang.String �߻� =>
	 * List<String>���� �ؼ� �߻��� ��������.. <?>�� �ٲ㼭 ���� int divisionNum = (Integer)
	 * boardData.get(0); System.out.println("divisionNum >> " + divisionNum);
	 * 
	 * boardData.remove(0); //0�� ������ ���� System.out.println("���� �� ������ >> " +
	 * boardData.size());
	 * 
	 * for(int i = 0; i < (boardData.size() /divisionNum); i++) {
	 * System.out.println(boardData.get(i));
	 * 
	 * BoardVo boardVo = new BoardVo(); boardVo.setBoardTitle((String)
	 * boardData.get(2*i)); boardVo.setBoardComment((String) boardData.get(2*i+1));
	 * 
	 * System.out.println("boardVo >> " + boardVo);
	 * 
	 * resultCnt = boardService.boardInsert(boardVo); }
	 * 
	 * result.put("success", (resultCnt > 0)?"Y":"N"); String callbackMsg =
	 * commonUtil.getJsonCallBackString(" ",result);
	 * System.out.println("callbackMsg::"+callbackMsg);
	 * 
	 * return callbackMsg; }
	 */

	@RequestMapping(value = "/board/boardWriteAction.do", method = RequestMethod.POST)
	@ResponseBody
//	@Transactional //�ǳ�.?
	public String boardWriteAction(@RequestBody List<BoardVo> boardList, Locale locale) throws Exception {
//		[{boardType=a01, boardTitle=1212, boardComment=222}, {boardType=a01, boardTitle=4545, boardComment=444}]
		System.out.println("���� �Խñ� board >>>>>>>>>>>>>>>>> " + boardList.toString());

		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();
		int resultCnt = -1;

//		java.util.LinkedHashMap cannot be cast to class com.spring.board.vo.BoardVo (java.util.LinkedHashMap
//		list�� �޾ƿ���� ������ �޾ƿ� �� objectMapper.readValue()�� �θ��� �ǰ� ArrayList.class ��� Ŭ���� ��ü�� ������ �ȴ�.
//		json���� ArrayList��� ��ü�� ������ȭ �ؾ��ϴµ� Ÿ���� �𸣱� ������ �߻��ϴ� ����..
//		==>�ؽ����� ����ϰų� ��ũ���ؽ��� Ȥ�� ��ü�� ���� Ŀ����
//		���� ����� ����� ���� � Ŭ������ �о�;� �ϴ��� �������
		ObjectMapper mapper = new ObjectMapper();
		String jsonBoardList = mapper.writeValueAsString(boardList);

		List<BoardVo> boardVoList = mapper.readValue(jsonBoardList, new TypeReference<List<BoardVo>>() {
		});

		// boardVo��� ��ü�� ���� �����͸� �����(�˾Ƽ� ����)
		for (BoardVo boardVo : boardVoList) {
			resultCnt = boardService.boardInsert(boardVo);
			System.out.println("resultCnt >> " + resultCnt);
		}

		result.put("success", (resultCnt > 0) ? "Y" : "N");
		String callbackMsg = commonUtil.getJsonCallBackString(" ", result);
		System.out.println("callbackMsg::" + callbackMsg);

		return callbackMsg;
	}

	@RequestMapping(value = "/board/boardTypesAction.do", method = RequestMethod.GET)
	@ResponseBody
	public List<ComCodeVo> boardTypesAction(Locale locale) throws Exception {

		List<ComCodeVo> codeList = new ArrayList<ComCodeVo>();
		ComCodeVo codeVo = new ComCodeVo();
		codeVo.setCodeType("menu");
		codeList = boardService.selectCodeList(codeVo);
		return codeList;
	}

//requestMapping�� Ŭ���� ���� �Ἥ "/board"�� �������� ���� ����� @GetMapping�̳� @PostMapping�� ������൵ ������~

	@RequestMapping(value = "/board/{boardType}/{boardNum}/boardModify.do", method = RequestMethod.GET)
	public String boardModify(Locale locale, Model model, @PathVariable("boardType") String boardType,
			@PathVariable("boardNum") int boardNum) throws Exception {

		System.out.println("========================get========================");

		System.out.println(boardType);
		System.out.println(boardNum);

		BoardVo boardVo = new BoardVo();
		boardVo = boardService.selectBoard(boardType, boardNum);
		System.out.println(boardVo.toString());

		model.addAttribute("boardType", boardType);
		model.addAttribute("boardNum", boardNum);
		model.addAttribute("board", boardVo);
		return "board/boardModify";
	}

	@RequestMapping(value = "/board/boardModifyAction.do", method = RequestMethod.POST)
	@ResponseBody
	public String boardModifyAction(Locale locale, BoardVo boardVo, Model model) throws Exception {

		System.out.println("=========================post=======================");
		System.out.println("boardVo >>> " + boardVo.toString());
		// boardType���� null�� ���� �߻�.. �ֳĸ� ������Ʈ������ ���������� �ʾҰ� hidden���� ���������� �ʾұ� ����
		// ������Ʈ�� �����Ƽ� �׳� hidden���� ������

		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();

		int resultCnt = boardService.boardUpdate(boardVo);
		System.out.println("resultCnt >>>>>>>>>>>>>>>>>> " + resultCnt);
		// ������� ���� �����̹Ƿ� ����� �����ΰǰ�?
		result.put("success", (resultCnt > 0) ? "Y" : "N");

		String callbackMsg = commonUtil.getJsonCallBackString(" ", result);

		System.out.println("callbackMsg::" + callbackMsg);

		return callbackMsg;
	}

	@RequestMapping(value = "/board/boardRemoveAction.do", method = RequestMethod.POST)
	@ResponseBody // ������ json�����͸� �νĸ��ϴ� �� ����...? callbackMsg ��ȯ�� �ȵ�
	public String boardRemove(Locale locale, BoardVo boardVo, Model model) throws Exception {

		System.out.println("boardRemoveAction~~~~~");
		System.out.println("delete �� board >>>>>>>>>>>>>>>>>>>>>> \n" + boardVo);
//		
//		boardVo = boardService.selectBoard(boardVo.getBoardType(), boardVo.getBoardNum());
//		System.out.println("delete �� board >>>>>>>>>>>>>>>>>>>>>> \n" + boardVo);
		System.out.println("boardType >> " + boardVo.getBoardType());
		System.out.println("boardNum >> " + boardVo.getBoardNum());

		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();

		int resultCnt = boardService.boardDelete(boardVo);
		System.out.println("resultCnt >>>>>>>>>>>>>>>>>> " + resultCnt);
		result.put("success", (resultCnt > 0) ? "Y" : "N");

		String callbackMsg = commonUtil.getJsonCallBackString(" ", result);

		System.out.println("callbackMsg::" + callbackMsg);
		System.out.println("������ ��ȣ >> " + boardVo.getBoardNum());

		model.addAttribute("msg", "�Խñ��� �����Ǿ����ϴ�.");

		return callbackMsg;
	}

	@RequestMapping(value = "/board/boardSearchAction.do", method = RequestMethod.POST)
	@ResponseBody
	public List<BoardVo> boardSearchAction(@RequestBody List<String> boardList, Model model, Locale locale)
			throws Exception {
		PageVo pageVo = new PageVo();

		int page = 1;
		int totalCnt = 0;
		if (pageVo.getPageNo() == 0) {
			pageVo.setPageNo(page);
		}

		List<BoardVo> searchBoardList = new ArrayList<BoardVo>();
		// codeId�� ã��
		pageVo.setCodeId(boardList);
		searchBoardList.addAll(boardService.SelectBoardList(pageVo));

		System.out.println(searchBoardList.toString());
		return searchBoardList;
	}

	@RequestMapping(value = "/board/boardJoin.do", method = RequestMethod.GET)
	public String boardjoin(Locale locale, Model model, ComCodeVo codeVo) throws Exception {

		List<ComCodeVo> codeList = new ArrayList<ComCodeVo>();

		codeVo.setCodeType("phone");
		codeList = boardService.selectCodeList(codeVo);
		model.addAttribute("codeList", codeList);

		return "board/boardJoin";

	}

	@RequestMapping(value = "/board/boardUserIdCheckAction.do", method = RequestMethod.POST)
	@ResponseBody
	public int boardUserIdCheckAction(@RequestBody UserInfoVo userVo, Model model, Locale locale) throws Exception {
		System.out.println(">>>>>>>>>>>>>>>>>>>> " + userVo.toString()); // userId=212tt �̷��� ���� ����!

		int userIdCnt = boardService.userIdCheck(userVo);
		System.out.println(">>>>>>>>>>>>>>>>>>>>" + userIdCnt);

		if (userIdCnt == 0) {
			userIdCnt = 0;
		} else {
			userIdCnt = -1;
		}

		return userIdCnt;
	}

	@RequestMapping(value = "/board/boardUserPwCheckAction.do", method = RequestMethod.POST)
	@ResponseBody
	public int boardUserPwCheckAction(@RequestBody List<String> pwList, Model model, Locale locale) throws Exception {
		// String���� �޴� ��� {"userPw":"1313","userPwChk":"1313"}
		// List<String>���� �޴� ���[{userPw=111, userPwChk=111}]
		// ajax���� pwList�� ���� ���� ����� [123, 122]

		int userPwdCnt = -1;

		String userPw = pwList.get(0).toString();
		String userPwChk = pwList.get(1).toString();

		System.out.println("pwdcheck >> " + userPw + " " + userPwChk);
		if (userPw.equals(userPwChk)) {
			// userPw == userPwChk�� ���� ���̿��� �������� �ɷ� ���� �ּҰ� ��
			// ==> ���� ���ڿ� ���ϵ��� equals ���
			userPwdCnt = 1;
		} else {
			userPwdCnt = 0;
		}

		return userPwdCnt;
	}

	@RequestMapping(value = "/board/boardUserjoinAction.do", method = RequestMethod.POST)
	@ResponseBody
	public String boardUserjoinAction(UserInfoVo userVo, Model model, Locale locale) throws Exception {

//		ObjectMapper mapper = new ObjectMapper();
//		String jsonUserInfoList = mapper.writeValueAsString(userList);
//
//		List<UserInfoVo> userInfoList = mapper.readValue(jsonUserInfoList, new TypeReference<List<UserInfoVo>>() {
//		});

		System.out.println(">>>>>>>>>>>>>>>>>>>> " + userVo); // �ּҰ�����...

		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();

		int resultCnt = boardService.userInsert(userVo);
		// ORA-00947: not enough values �߻�!
		// userAddr2�� userCompany�� ���� �Է����� ������ �״�� null�� �Ǿ ���� ����...
		// ��.. ���� userVo�� ����� �־���ϴ°ɱ�?-> jsp���� �Ϸ����ߴµ� if�������� �ϴ�

		System.out.println("resultCnt >>>>>>>>>>>>>>>>>> " + resultCnt);
		result.put("success", (resultCnt > 0) ? "Y" : "N");

		String callbackMsg = commonUtil.getJsonCallBackString(" ", result);

		System.out.println("callbackMsg::" + callbackMsg);

		return callbackMsg;
	}

	@RequestMapping(value = "/board/boardLogin.do", method = RequestMethod.GET)
	public String boardLogin(Locale locale, Model model) throws Exception {

		return "board/boardLogin";
	}

	@RequestMapping(value = "/board/boardUserLoginAction.do", method = RequestMethod.POST)
	@ResponseBody
	public UserInfoVo boardUserLoginAction(UserInfoVo userVo, HttpServletRequest request, Model model, Locale locale)
			throws Exception {

		System.out.println(">>>>>>>>>>>>>>>>>>>> " + userVo.toString()); // �ּҰ�����...

		UserInfoVo loginUser = boardService.selectUser(userVo);

		if (loginUser != null) {
			HttpSession session = request.getSession();
			session.setAttribute("loginUser", loginUser); // user�� ������ 1 (count ����)
			System.out.println(session.toString());
			System.out.println(session.getAttribute("loginUser"));
			// UserInfoVo [userId=whffu1, userPw=whffu1!, userName=null, userPhone1=null,
			// userPhone2=null, userPhone3=null, userAddr1=null, userAddr2=none,
			// userCompany=none, creator=null, modifier=null]
		}
		return loginUser;
	}

	@RequestMapping(value = "/board/boardUserLogoutAction.do", method = RequestMethod.POST)
	@ResponseBody
	public String boardUserLogoutAction(UserInfoVo userVo, HttpServletRequest request, Model model, Locale locale)
			throws Exception {

		System.out.println(">>>>>>>>>boardUserLogoutAction>>>>>>>>>> " + userVo.toString());

		int loginCheckNum = boardService.userLoginCheck(userVo);
		System.out.println("resultCnt >>>>>>>>>>>>>>>>>> " + loginCheckNum);

		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();

		result.put("success", (loginCheckNum > 0) ? "Y" : "N");

		String callbackMsg = commonUtil.getJsonCallBackString(" ", result);

		System.out.println("callbackMsg::" + callbackMsg);

		if (userVo.getUserId() != null) {
			HttpSession session = request.getSession();
			session.removeAttribute("loginUser");
			System.out.println("���Ǹ���");
		}
		return callbackMsg;
	}

	@RequestMapping(value = "/mbti/mbtiTest.do", method = RequestMethod.GET)
	public String mbtiTest(Locale locale, Model model, PageVo pageVo) throws Exception {

		List<BoardVo> mbtiList = new ArrayList<BoardVo>();
		List<ComCodeVo> codeList = new ArrayList<ComCodeVo>();

		int page = 1;

		if (pageVo.getPageNo() == 0) {
			pageVo.setPageNo(page);
			;
		}

		ComCodeVo codeVo = new ComCodeVo();
		codeVo.setCodeType("mbti");

		codeList = boardService.selectCodeList(codeVo);

		System.out.println("codeList >>> " + codeList);

		List<String> codeIdList = new ArrayList<>();
		for (ComCodeVo comCode : codeList) {
			codeIdList.add(comCode.getCodeId());
		};

		pageVo.setCodeId(codeIdList);
		pageVo.setCodeType("mbti");
		mbtiList = boardService.SelectMbtiList(pageVo);

		model.addAttribute("mbtiList", mbtiList);
		model.addAttribute("codeList", codeList);
		model.addAttribute("pageNo", page);

		return "mbti/mbtiTest";
	}

	@RequestMapping(value = "/mbti/mbtiResultAction.do", method = RequestMethod.POST)
	@ResponseBody
	public String mbtiResultAction(@RequestBody List<String> resultList, 
			Model model, Locale locale, HttpSession session) throws Exception {
		
		List<String> mbtiResultList = new ArrayList<String>();
		List<String> myList= new ArrayList<String>();
		String mbtiCollection = "";
		int pageNumber = 0;
		
		System.out.println(">>>>>>>>>mbtiResultAction>>>>>>>>>> " + resultList.toString());
//		>>>>>>>>>mbtiResultAction>>>>>>>>>> [PJ_2_4, IE_2_4, NS_2_4, EI_2_4, TF_2_4]
//		���� ������! �ϳ��� �������� ��! PJ => P

		for (int i = 0; i < resultList.size(); i++) {
			String[] splitList = resultList.get(i).split("_");
			//selectNum : ������ ����(+-)
			int selectNum =  Integer.parseInt(splitList[2]) ;
			//TF �̷������� �������� �����ϴ� ���(value=> 5 6 7)
			if(selectNum > 4) { 
				//selectNum => 567�� ���� ���� ==> 123�� �Ǿ �ݺ��ǵ���
				for(int j = 0; j < (selectNum - 4) ; j++) {
					//�ι�° �� ����
					mbtiCollection += splitList[0];
				}
				System.out.println("mbtiCollection >>>> " + mbtiCollection);
			
			//���� �ϴ� ���(value=> 1 2 3)
			} else if(selectNum < 4){ 
				//selectNum => 123�� ���� ���� ==> 321�� �Ǿ �ݺ��ǵ���
				for(int j = 0; j < (4 - selectNum) ; j++) {
					mbtiCollection += splitList[0];
				}
				System.out.println("mbtiCollection >>>> " + mbtiCollection);
			} 
		}
		
		//����� ����...
		mbtiResultList.add(mbtiCollection);
		System.out.println("mbtiResultList >>>> " + mbtiResultList);
		
		//������ ������ ���� ����
		if(session.getAttribute("mbtiResultSession") == null) {
			session.setAttribute("mbtiResultSession", mbtiResultList);
			pageNumber = 1;
		} 
		//������ ������ ���������ٰ� ���ο� �� �߰��ؼ� ����
		else { 
			myList = (List<String>) session.getAttribute("mbtiResultSession");
			myList.addAll(mbtiResultList);
			System.out.println(myList.toString());
			pageNumber = myList.size();
			session.setAttribute("mbtiResultSession", myList);
		}

		System.out.println("pageNumberpageNumber >>>> " + pageNumber);
		
		//��Ʈ�ѷ��� �̷��� ��� �����ص� �Ǵ°ɱ�?
		if(pageNumber < 4) {
			return String.valueOf(pageNumber+1);
		} else {// 5���׾� 4������ �׽�Ʈ�� �� �������
			return myList.toString();
		}
	}

	@RequestMapping(value = "/mbti/mbtiResult.do", method = RequestMethod.GET)
	public String mbtiResult(Locale locale, Model model, HttpSession session ) throws Exception {

		if(session.getAttribute("mbtiResultSession") != null) {
			List<String> mbtiResultSession =  (List<String>) session.getAttribute("mbtiResultSession");
			
			System.out.println(mbtiResultSession.toString());
			//[JTIPF, PEPPF, FSESF, PISIT]
			
			List<String> mbtiTypeList = boardService.mbtiTypeList();
			System.out.println("mbtiTypeList>>> " + mbtiTypeList + "mbtiTypeList size>>> " + mbtiTypeList.size());
			//mbtiTypeList>>> [E, F, I, J, N, P, S, T] size 8��! : ���ĺ����̴�..
	
			Map<String, String> mbtiTypeMap = new HashMap<String, String>();
			mbtiTypeMap.put("first", "EI");
			mbtiTypeMap.put("seconde", "NS");
			mbtiTypeMap.put("third", "TF");
			mbtiTypeMap.put("forth", "PJ");
			
			String[] first = mbtiTypeMap.get("first").toString().split("");
			String[] seconde = mbtiTypeMap.get("seconde").toString().split("");
			String[] third = mbtiTypeMap.get("third").toString().split("");
			String[] fiforthrst = mbtiTypeMap.get("forth").toString().split("");
			
	        Map<String, Integer> resultMap = new HashMap(); 
	        
			for(int i = 0; i < mbtiTypeList.size(); i++ ) {
				
		        String target = mbtiTypeList.get(i); // ã�� ����
		
		        // ���� ǥ���� ���� ����
		        String regex = String.valueOf(target);
		        Pattern pattern = Pattern.compile(regex);
		
		        // Matcher�� ����Ͽ� ��ġ�ϴ� �κ� ã��
		        Matcher matcher = pattern.matcher(mbtiResultSession.toString());
		        int count = 0;
		        while (matcher.find()) {
		            count++;
		        }
		
		        resultMap.put(mbtiTypeList.get(i), count);
		        System.out.println("���� '" + target + "'�� ����: " + count);
			}
	
			
			List<String> mbtiResult = new ArrayList<String>();
			//E�� I�� ���� ���ϱ�......
			if(resultMap.get("E") > resultMap.get("I")) {
				mbtiResult.add("E");
			} 
			//������ ���� ���, ���ĺ� �����ְ� �켱
			else if( resultMap.get("E") ==  resultMap.get("I") ) {
				//�����ڵ�� ��... �� �� ������(���ĺ����� ������)�� result�� �־���
				String result = ('E' < 'I') ? "E" : "I";
				mbtiResult.add(result);
			}else {
				mbtiResult.add("I");
			}
			
			//N�̶� S ��
			if(resultMap.get("N") > resultMap.get("S")) {
				mbtiResult.add("N");
			}else if( resultMap.get("N") ==  resultMap.get("S") ) {
				//�����ڵ�� ��... �� �� ������(���ĺ����� ������)�� result�� �־���
				String result = ('N' < 'S') ? "N" : "S";
				mbtiResult.add(result);
			} else {
				mbtiResult.add("S");
			}
			//������ ���� ���, ���ĺ� �����ְ� �켱
			
			
			//T VS F
			if(resultMap.get("T") > resultMap.get("F")) {
				mbtiResult.add("T");
			}else if( resultMap.get("T") ==  resultMap.get("F") ) {
				//�����ڵ�� ��... �� �� ������(���ĺ����� ������)�� result�� �־���
				String result = ('T' < 'F') ? "T" : "F";
				mbtiResult.add(result);
			} else {
				mbtiResult.add("F");
			}
			//������ ���� ���, ���ĺ� �����ְ� �켱
			
			
			//J VS P
			if(resultMap.get("J") > resultMap.get("P")) {
				mbtiResult.add("J");
			}else if( resultMap.get("J") ==  resultMap.get("P") ) {
				//�����ڵ�� ��... �� �� ������(���ĺ����� ������)�� result�� �־���
				String result = ('J' < 'P') ? "J" : "P";
				mbtiResult.add(result);
			} else {
				mbtiResult.add("P");
			}
			//������ ���� ���, ���ĺ� �����ְ� �켱
			
			String result = String.join("", mbtiResult);
			System.out.println("result >>>> "  + result);
	
			model.addAttribute("mbtiResult" , result);
			System.out.println("result >>>> "  + result);
			
			
			session.removeAttribute("mbtiResultSession");
			
			return "mbti/mbtiResult";
		}
		else {
			model.addAttribute("mbtiResult" , "");
			return "mbti/mbtiResult";
			
		}
	}

}
