package com.spring.board.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

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
import com.spring.board.vo.CareerVo;
import com.spring.board.vo.CertificateVo;
import com.spring.board.vo.ComCodeVo;
import com.spring.board.vo.EducationVo;
import com.spring.board.vo.PageVo;
import com.spring.board.vo.RecruitVo;
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
		 * codeList>>>>>>>>>>> [ComCodeVo [codeType=menu, codeId=a01, codeName=일반,
		 * creator=null, modifier=null], ComCodeVo [codeType=menu, codeId=a02,
		 * codeName=Q&A, creator=null, modifier=null], ComCodeVo [codeType=menu,
		 * codeId=a03, codeName=익명, creator=null, modifier=null], ComCodeVo
		 * [codeType=menu, codeId=a04, codeName=자유, creator=null, modifier=null]]
		 */

		List<String> codeIdList = new ArrayList<>();
		for (ComCodeVo comCode : codeList) {
			codeIdList.add(comCode.getCodeId());
		}
		;
		pageVo.setCodeId(codeIdList);
		boardList = boardService.SelectBoardList(pageVo);

		UserInfoVo loginUser = (UserInfoVo) session.getAttribute("loginUser");
		System.out.println("session에서 가져온 userVo >>> " + loginUser);

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

		codeVo.setCodeType("menu");
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
	 * @ResponseBody // @Transactional //되나.? public String boardWriteAction(Locale
	 * locale, @RequestBody List<?> boardData) throws Exception{
	 * 
	 * System.out.println("현재 게시글 board >>>>>>>>>>>>>>>>> " + boardData.toString());
	 * System.out.println("현재 게시글 board >>>>>>>>>>>>>>>>> " + boardData.size());
	 * 
	 * HashMap<String, String> result = new HashMap<String, String>(); CommonUtil
	 * commonUtil = new CommonUtil(); int resultCnt = -1;
	 * 
	 * //class java.lang.Integer cannot be cast to class java.lang.String 발생 =>
	 * List<String>으로 해서 발생한 문제였음.. <?>로 바꿔서 진행 int divisionNum = (Integer)
	 * boardData.get(0); System.out.println("divisionNum >> " + divisionNum);
	 * 
	 * boardData.remove(0); //0번 데이터 삭제 System.out.println("삭제 후 사이즈 >> " +
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
//	@Transactional //되나.?
	public String boardWriteAction(@RequestBody List<BoardVo> boardList, Locale locale) throws Exception {
//		[{boardType=a01, boardTitle=1212, boardComment=222}, {boardType=a01, boardTitle=4545, boardComment=444}]
		System.out.println("현재 게시글 board >>>>>>>>>>>>>>>>> " + boardList.toString());

		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();
		int resultCnt = -1;

//		java.util.LinkedHashMap cannot be cast to class com.spring.board.vo.BoardVo (java.util.LinkedHashMap
//		list로 받아오라고 했으나 받아올 떄 objectMapper.readValue()를 부르게 되고 ArrayList.class 라는 클래스 객체를 지나게 된다.
//		json에서 ArrayList라는 객체로 역직렬화 해야하는데 타입을 모르기 때문에 발생하는 오류..
//		==>해쉬맵을 사용하거나 링크드해쉬맵 혹은 객체를 직접 커스텀
//		내가 사용한 방법은 직접 어떤 클래스로 읽어와야 하는지 명시해줌
		ObjectMapper mapper = new ObjectMapper();
		String jsonBoardList = mapper.writeValueAsString(boardList);

		List<BoardVo> boardVoList = mapper.readValue(jsonBoardList, new TypeReference<List<BoardVo>>() {
		});

		// boardVo라는 객체에 전부 데이터를 담아줌(알아서 맵핑)
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

//requestMapping을 클래스 위에 써서 "/board"를 공통으로 갖게 만들고 @GetMapping이나 @PostMapping을 사용해줘도 괜찮다~

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
		// boardType에서 null값 에러 발생.. 왜냐면 쿼리스트링에서 가져오지도 않았고 hidden으로 가져오지도 않았기 때문
		// 쿼리스트링 귀찮아서 그냥 hidden으로 가져옴

		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();

		int resultCnt = boardService.boardUpdate(boardVo);
		System.out.println("resultCnt >>>>>>>>>>>>>>>>>> " + resultCnt);
		// 영향받은 행의 개수이므로 양수면 성공인건가?
		result.put("success", (resultCnt > 0) ? "Y" : "N");

		String callbackMsg = commonUtil.getJsonCallBackString(" ", result);

		System.out.println("callbackMsg::" + callbackMsg);

		return callbackMsg;
	}

	@RequestMapping(value = "/board/boardRemoveAction.do", method = RequestMethod.POST)
	@ResponseBody // 없으면 json데이터를 인식못하는 것 같음...? callbackMsg 반환이 안됨
	public String boardRemove(Locale locale, BoardVo boardVo, Model model) throws Exception {

		System.out.println("boardRemoveAction~~~~~");
		System.out.println("delete 할 board >>>>>>>>>>>>>>>>>>>>>> \n" + boardVo);
//		
//		boardVo = boardService.selectBoard(boardVo.getBoardType(), boardVo.getBoardNum());
//		System.out.println("delete 할 board >>>>>>>>>>>>>>>>>>>>>> \n" + boardVo);
		System.out.println("boardType >> " + boardVo.getBoardType());
		System.out.println("boardNum >> " + boardVo.getBoardNum());

		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();

		int resultCnt = boardService.boardDelete(boardVo);
		System.out.println("resultCnt >>>>>>>>>>>>>>>>>> " + resultCnt);
		result.put("success", (resultCnt > 0) ? "Y" : "N");

		String callbackMsg = commonUtil.getJsonCallBackString(" ", result);

		System.out.println("callbackMsg::" + callbackMsg);
		System.out.println("삭제된 번호 >> " + boardVo.getBoardNum());

		model.addAttribute("msg", "게시글이 삭제되었습니다.");

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
		// codeId로 찾음
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
		System.out.println(">>>>>>>>>>>>>>>>>>>> " + userVo.toString()); // userId=212tt 이렇게 값이 들어옴!

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
		// String으로 받는 경우 {"userPw":"1313","userPwChk":"1313"}
		// List<String>으로 받는 경우[{userPw=111, userPwChk=111}]
		// ajax에서 pwList에 각각 값을 담아줌 [123, 122]

		int userPwdCnt = -1;

		String userPw = pwList.get(0).toString();
		String userPwChk = pwList.get(1).toString();

		System.out.println("pwdcheck >> " + userPw + " " + userPwChk);
		if (userPw.equals(userPwChk)) {
			// userPw == userPwChk는 같은 값이여도 오류나는 걸로 봐서 주소값 비교
			// ==> 직접 문자열 비교하도록 equals 사용
			userPwdCnt = 1;
		} else {
			userPwdCnt = 0;
		}

		return userPwdCnt;
	}

	@RequestMapping(value = "/board/boardUserjoinAction.do", method = RequestMethod.POST)
	@ResponseBody
	public String boardUserjoinAction(UserInfoVo userVo, Model model, Locale locale) throws Exception {

		System.out.println(">>>>>>>>>>>>>>>>>>>> " + userVo); // 주소값나옴...

		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();

		int resultCnt = boardService.userInsert(userVo);
		// ORA-00947: not enough values 발생!

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

		System.out.println(">>>>>>>>>>>>>>>>>>>> " + userVo.toString()); // 주소값나옴...

		UserInfoVo loginUser = boardService.selectUser(userVo);

		if (loginUser != null) {
			HttpSession session = request.getSession();
			session.setAttribute("loginUser", loginUser); // user가 있으면 1 (count 쿼리)
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
			System.out.println("세션만료");
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
		
		for (int i = 0; i < resultList.size(); i++) {
			String[] splitList = resultList.get(i).split("_"); //PJ_2_4 => [PJ, 2, 4]
			String[] splitType = splitList[0].split("");
			//selectNum : [PJ, 2, 4] 마지막 숫자 => 점수를 나타냄
			int selectNum =  Integer.parseInt(splitList[2]) ;
			
			int repeatNum = 0;
			
			// 라디오 버튼 값에 따라 동의 정도를 변환하는 메서드
		    switch (selectNum) {
		        case 1:
		        	repeatNum = 3;
		        	break;
		        case 2:
		        	repeatNum = 2;
		        	break;
		        case 3:
		        	repeatNum = 1;
		        	break;
		        case 4:
		        	repeatNum = 0;
		        	break;
		        case 5:
		        	repeatNum = 1;
		        	break;
		        case 6:
		        	repeatNum = 2;
		        	break;
		        case 7:
		        	repeatNum = 3;
		        	break;
		    }

			//TF 이런식으로 나왔을때 비동의하는 경우(value=> 5 6 7)
			if(selectNum > 4) { 
				mbtiCollection += splitType[1].repeat(repeatNum);
				System.out.println("mbtiCollection >>>> " + mbtiCollection);
			
			//동의 하는 경우(value=> 1 2 3)
			} else if(selectNum < 4){ 
				mbtiCollection += splitType[0].repeat(repeatNum);
				System.out.println("mbtiCollection >>>> " + mbtiCollection);
			} 
		}
		
		//결과값 저장...
		mbtiResultList.add(mbtiCollection);
		System.out.println("mbtiResultList >>>> " + mbtiResultList);
		
		//세션이 없으면 만들어서 저장
		if(session.getAttribute("mbtiResultSession") == null) {
			session.setAttribute("mbtiResultSession", mbtiResultList);
			pageNumber = 1;
		} 
		//세션이 있으면 기존값에다가 새로운 값 추가해서 저장
		else { 
			myList = (List<String>) session.getAttribute("mbtiResultSession");
			myList.addAll(mbtiResultList);
			System.out.println(myList.toString());
			pageNumber = myList.size(); //[JTIPF, PEPPF, FSESF, PISIT] 이런식으로 저장됨
			session.setAttribute("mbtiResultSession", myList);
		}

		System.out.println("pageNumberpageNumber >>>> " + pageNumber);
		
		//컨트롤러가 이렇게 길고 복잡해도 되는걸까?
		if(pageNumber < 4) {
			return String.valueOf(pageNumber+1);
		} else {// 5문항씩 4페이지 테스트가 다 끝난경우
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
			//mbtiTypeList>>> [E, F, I, J, N, P, S, T] size 8개! : 알파벳순이다..
			
	        Map<String, Integer> resultMap = new HashMap(); 
			for(int i = 0; i < mbtiTypeList.size(); i++ ) {
				
		        String target = mbtiTypeList.get(i); // 찾을 문자
		
		        // 정규 표현식 패턴 생성
		        String regex = String.valueOf(target);
		        Pattern pattern = Pattern.compile(regex);
		
		        // Matcher를 사용하여 일치하는 부분 찾기
		        Matcher matcher = pattern.matcher(mbtiResultSession.toString());
		        int count = 0;
		        while (matcher.find()) {
		            count++;
		        }
		
		        //"E", 3 이런식으로 값을 저장
		        resultMap.put(mbtiTypeList.get(i), count); 
		        System.out.println("문자 '" +mbtiTypeList.get(i) + "'의 개수: " + count);
			}
			
			//2차원 배열에 값을 저장함.....
			char[][] mbtiResultList = {
			    {'E', 'I'},
			    {'N', 'S'},
			    {'T', 'F'},
			    {'P', 'J'}
			};
	
			String mbtiResult = "";

			// 정렬된 순서대로 값을 가져와서 결과 문자열에 추가함
			for(int i = 0; i < mbtiResultList.length ; i++) {
					//알파벳 별 개수비교
					if(resultMap.get(String.valueOf(mbtiResultList[i][0])) > resultMap.get(String.valueOf(mbtiResultList[i][1])) ) {
						mbtiResult += String.valueOf(mbtiResultList[i][0]);
					}
					//개수가 동일한 경우 오름차순으로 저장
					else if(resultMap.get(String.valueOf(mbtiResultList[i][0])) == resultMap.get(String.valueOf(mbtiResultList[i][1]))) {
						mbtiResult += (mbtiResultList[i][0] <= mbtiResultList[i][1]) ? mbtiResultList[i][0] : mbtiResultList[i][1];
					}
					else {
						mbtiResult += String.valueOf(mbtiResultList[i][1]);
					}
			}

			System.out.println("result =============> " + mbtiResult);

			model.addAttribute("mbtiResult", mbtiResult);
			session.removeAttribute("mbtiResultSession");
			
			return "mbti/mbtiResult";
		
		}//end if(session != null)
	
		else { //session == null
			model.addAttribute("mbtiResult" , "");
			return "mbti/mbtiResult";
		}
	}

	
	@RequestMapping(value = "/recruit/login.do", method = RequestMethod.GET)
	public String recruitLogin(HttpSession session) {
	
		if(session.getAttribute("recruitLoginUser") != null) {
			session.removeAttribute("recruitLoginUser");
			session.removeAttribute("eduList");
			session.removeAttribute("careerList");
			session.removeAttribute("certiList");
		}
		return "/recruit/login";
	}
	
	@RequestMapping(value = "/recruit/recruitLoginAction.do", method = RequestMethod.POST)
	@ResponseBody
	public RecruitVo recruitLoginAction(RecruitVo recruitVo, HttpSession session, Model model, Locale locale) throws Exception {
		
		System.out.println("recruitVo >>>>> " + recruitVo.getName() + " "+ recruitVo.getPhone());
		System.out.println("recruitVo.toString >>>>> " + recruitVo.toString());
		
		RecruitVo recruitLoginUser = boardService.recruitLoginCheck(recruitVo);
		System.out.println("================ recruitLoginUser >>> "+recruitLoginUser);
		
		// 기존 회원인 경우
		if (recruitLoginUser != null) {
			session.setAttribute("recruitLoginUser", recruitLoginUser);
			System.out.println(session.getAttribute("recruitLoginUser"));
			
			List<EducationVo> eduList = boardService.selectLoginUserEducation(recruitVo);
			List<CareerVo> careerList = boardService.selectLoginUserCareer(recruitVo);
			List<CertificateVo> certiList = boardService.selectLoginUserCertificate(recruitVo);
			
			System.out.println("eduList >>> \n" + eduList);
			
			session.setAttribute("eduList", eduList);
			session.setAttribute("careerList", careerList);
			session.setAttribute("certiList", certiList);
		} 
		else { //기존 회원이 아닌 경우
			session.setAttribute("recruitLoginUser", recruitVo);
			System.out.println(session.getAttribute("recruitLoginUser"));
		}
		
		return recruitLoginUser;
	}
	
	@RequestMapping(value = "/recruit/main.do", method = RequestMethod.GET)
	public String recruitMain(HttpSession session, Model model, Locale locale) {
		
		RecruitVo recruitLoginUser =  (RecruitVo) session.getAttribute("recruitLoginUser");
		if(recruitLoginUser == null) {
			return "recruit/login"; //세션이 null인 경우 (로그인이 끊긴경우)
		}
		//학력사항 경력사항 계산
		List<EducationVo> eduList =  (List<EducationVo>) session.getAttribute("eduList");
		List<CareerVo> careerList =  (List<CareerVo>) session.getAttribute("careerList");
		
		//학력사항 계산 => desc를 통해서 재학기간 제일 최신이 첫번째값으로 오게 함
		if(eduList.size() != 0) {
			double eduStart =  eduList.get(0).getStart_period() ; //2020.01
			String[] edustartArray = String.valueOf(eduStart).split("\\."); // 정규식에서 "."은 "\\."이여야 인식됨
			double eduEnd = eduList.get(0).getEnd_period() ;
			String[] eduendArray = String.valueOf(eduEnd).split("\\.");
			
			int eduYear = Integer.valueOf(eduendArray[0]) - Integer.valueOf(edustartArray[0]);
			
			int edumonth = ( (Integer.valueOf(eduendArray[1]))*12 - (Integer.valueOf(edustartArray[1]))*12 )/(-12);
			
			String calEdu ;
			if(eduYear < 1)
				calEdu= eduList.get(0).getSchool_name() + "(" + edumonth + "개월) " + eduList.get(0).getDivision();
			//대학교(4년) 졸업
			else
				calEdu= eduList.get(0).getSchool_name() + "(" + eduYear + "년) " + eduList.get(0).getDivision();
			
			model.addAttribute("calEdu", calEdu);
			System.out.println("calEdu >>>>>>>>>>>>>>> " + calEdu);
			System.out.println("careerList >>>>>>>>>>>>>>> " + careerList);
		} else {
			model.addAttribute("calEdu", "없음");
		}
		
		if( careerList.size() != 0) {
			//경력사항 계산 => desc를 통해서 재학기간 제일 최신이 첫번째값으로 오게 함
			String careerStart =  careerList.get(0).getStart_period() ; //2020.01
			String[] careerStartArray = String.valueOf(careerStart).split("\\.");
			String careerEnd = careerList.get(0).getEnd_period() ;
			String[] careerEndArray = String.valueOf(careerEnd).split("\\.");
			
			int careerYear = Integer.valueOf(careerEndArray[0]) - Integer.valueOf(careerStartArray[0]);
			int careerMonth = (Integer.valueOf(careerEndArray[1]) - Integer.valueOf(careerStartArray[1])) / 12;
			
			if(careerMonth < 0) {
				careerYear = careerYear - 1;
				careerMonth = careerMonth * -1;
			}
			
			String calCareer = "경력 " + careerYear+ "년 " + careerMonth + "개월";
			
			model.addAttribute("calCareer", calCareer);
			System.out.println("calCareer >>>>>>>>>>>>>>> " + calCareer);
		} else {
			model.addAttribute("calCareer", "없음");
		}
		return "recruit/main";
	}

	
	@RequestMapping(value = "/recruit/resumeSaveAction.do", method = RequestMethod.POST)
	@ResponseBody
	public String resumeSaveAction(@RequestBody Map<String, Object> requestData, Model model,
									HttpSession session, Locale locale) throws Exception {

		List<EducationVo> educationList = (List<EducationVo>) requestData.get("educationList");
	    List<CareerVo> careerList = (List<CareerVo>) requestData.get("careerList");
	    List<CertificateVo> certificateList = (List<CertificateVo>) requestData.get("certificateList");
	    List<RecruitVo> recruitVo = (List<RecruitVo>) requestData.get("recruitVo");
		
		System.out.println("현재 게시글 educationList >>>>>>>>>>>>>>>>> " + educationList.toString());
		System.out.println("현재 게시글 careerList >>>>>>>>>>>>>>>>> " + careerList.toString());
		System.out.println("현재 게시글 certificateList >>>>>>>>>>>>>>>>> " + certificateList.toString());
		System.out.println("현재 게시글 recruitVo >>>>>>>>>>>>>>>>> " + recruitVo.toString());

		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();
		
		int resultCnt = -1;
		
		ObjectMapper mapper = new ObjectMapper();
		String jsonRecruitVo = mapper.writeValueAsString(recruitVo);
		String jsonEduList = mapper.writeValueAsString(educationList);
		String jsonCareerList = mapper.writeValueAsString(careerList);
		String jsonCertificateList = mapper.writeValueAsString(certificateList);

		List<RecruitVo> recruitVoConverted = mapper.readValue(jsonRecruitVo, new TypeReference<List<RecruitVo>>() {});
		List<EducationVo> educationVoList = mapper.readValue(jsonEduList, new TypeReference<List<EducationVo>>() {});
		List<CareerVo> careerVoList = mapper.readValue(jsonCareerList, new TypeReference<List<CareerVo>>() {});
		List<CertificateVo> certificateVoList = mapper.readValue(jsonCertificateList, new TypeReference<List<CertificateVo>>() {});

		for (RecruitVo reVo : recruitVoConverted) { //한번만 진행됨 list로 안받으면 오류나서 일단 list사용..
			RecruitVo returnedUser = boardService.recruitLoginCheck(reVo);
			if(returnedUser != null) { //DB에 데이터가 있을 때
				
				boardService.deleteEducation(reVo);
				boardService.deleteCareer(reVo);
				boardService.deleteCertificate(reVo);
				
				boardService.deleteRecruit(reVo);

				boardService.insertRecruit(reVo);
				System.out.println("if(returnedUser != null) resultCnt >> " + resultCnt);
			}
			else { //DB에 데이터가 없을 때
				boardService.insertRecruit(reVo);
				System.out.println("if(returnedUser != null)의 else resultCnt >> " + resultCnt);
			}

			// EducationVo라는 객체에 전부 데이터를 담아줌(알아서 맵핑)
			for (EducationVo eduVo : educationVoList) {
				boardService.insertEducation(eduVo); //성공하면 1
				System.out.println("for (EducationVo eduVo : educationVoList)  resultCnt >> " + resultCnt);
			}
			for (CareerVo careerVo : careerVoList) {
				boardService.insertCareer(careerVo); //성공하면 1
				System.out.println("resultCnt >> " + resultCnt);
			}
			for (CertificateVo certificateVo : certificateVoList) {
				boardService.insertCertificate(certificateVo); //성공하면 1
				System.out.println("resultCnt >> " + resultCnt);
			}
			
			session.setAttribute("recruitLoginUser", reVo);

			//order by desc 년도로 정리된 list를 세션에 담아줌
			List<EducationVo> eduOrderedList = boardService.selectLoginUserEducation(reVo);
			List<CareerVo> careerOrderedList = boardService.selectLoginUserCareer(reVo);
			List<CertificateVo> certiOrderedList = boardService.selectLoginUserCertificate(reVo);
			
			session.setAttribute("eduList", eduOrderedList);
			session.setAttribute("careerList", careerOrderedList);
			session.setAttribute("certiList", certiOrderedList);
			
			resultCnt = 1;
		}
		
		result.put("success", (resultCnt > 0) ? "Y" : "N"); // for의 개수보다 크게하려면 어케할까...?
		String callbackMsg = commonUtil.getJsonCallBackString(" ", result);
		System.out.println("eduList::" + session.getAttribute("eduList"));
		System.out.println("careerList::" + session.getAttribute("careerList"));

		return callbackMsg;
	}
	
	@RequestMapping(value = "/recruit/resumeSubmitAction.do", method = RequestMethod.POST)
	@ResponseBody
	public String resumeSubmitAction(@RequestBody Map<String, Object> requestData,
			HttpSession session, Locale locale) throws Exception {
		
		List<EducationVo> educationList = (List<EducationVo>) requestData.get("educationList");
		List<CareerVo> careerList = (List<CareerVo>) requestData.get("careerList");
		List<CertificateVo> certificateList = (List<CertificateVo>) requestData.get("certificateList");
		List<RecruitVo> recruitVo = (List<RecruitVo>) requestData.get("recruitVo");
		
		System.out.println("현재 게시글 educationList >>>>>>>>>>>>>>>>> " + educationList.toString());
		System.out.println("현재 게시글 careerList >>>>>>>>>>>>>>>>> " + careerList.toString());
		System.out.println("현재 게시글 certificateList >>>>>>>>>>>>>>>>> " + certificateList.toString());
		System.out.println("현재 게시글 recruitVo >>>>>>>>>>>>>>>>> " + recruitVo.toString());
		
		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();
		int resultCnt = -1;
		
		ObjectMapper mapper = new ObjectMapper();
		String jsonRecruitVo = mapper.writeValueAsString(recruitVo);
		String jsonEduList = mapper.writeValueAsString(educationList);
		String jsonCareerList = mapper.writeValueAsString(careerList);
		String jsonCertificateList = mapper.writeValueAsString(certificateList);
		
		List<RecruitVo> recruitVoConverted = mapper.readValue(jsonRecruitVo, new TypeReference<List<RecruitVo>>() {});
		List<EducationVo> educationVoList = mapper.readValue(jsonEduList, new TypeReference<List<EducationVo>>() {});
		List<CareerVo> careerVoList = mapper.readValue(jsonCareerList, new TypeReference<List<CareerVo>>() {});
		List<CertificateVo> certificateVoList = mapper.readValue(jsonCertificateList, new TypeReference<List<CertificateVo>>() {});
		
		for (RecruitVo reVo : recruitVoConverted) { //한번만 진행됨 list로 안받으면 오류나서 일단 list사용..
			RecruitVo returnedUser = boardService.recruitLoginCheck(reVo);
			
			if(returnedUser != null) { //DB에 데이터가 있을 때
//				//recruit에 fk가 있어서 다른 테이블 먼저 삭제하게 연산자+괄호 사용..
//				resultCnt = (boardService.deleteEducation(reVo) * boardService.deleteCareer(reVo) * boardService.deleteCertificate(reVo))
//						+ boardService.deleteRecruit(reVo);
				resultCnt += boardService.deleteEducation(reVo);
				resultCnt += boardService.deleteCareer(reVo);
				resultCnt += boardService.deleteCertificate(reVo);
				resultCnt += boardService.deleteRecruit(reVo);
				
				resultCnt += boardService.insertRecruit(reVo);
				System.out.println("resultCnt >> " + resultCnt);
			}
			else { //DB에 데이터가 없을 때
				resultCnt += boardService.insertRecruit(reVo);
				System.out.println("resultCnt >> " + resultCnt);
			}
			
			// EducationVo라는 객체에 전부 데이터를 담아줌(알아서 맵핑)
			for (EducationVo eduVo : educationVoList) {
				resultCnt += boardService.insertEducation(eduVo); //성공하면 1
				System.out.println("resultCnt >> " + resultCnt);
			}
			for (CareerVo careerVo : careerVoList) {
				resultCnt += boardService.insertCareer(careerVo); //성공하면 1
				System.out.println("resultCnt >> " + resultCnt);
			}
			for (CertificateVo certificateVo : certificateVoList) {
				resultCnt += boardService.insertCertificate(certificateVo); //성공하면 1
				System.out.println("resultCnt >> " + resultCnt);
			}
			
			session.setAttribute("recruitLoginUser", reVo);
			
			//order by desc 년도로 정리된 list를 세션에 담아줌
			List<EducationVo> eduOrderedList = boardService.selectLoginUserEducation(reVo);
			List<CareerVo> careerOrderedList = boardService.selectLoginUserCareer(reVo);
			List<CertificateVo> certiOrderedList = boardService.selectLoginUserCertificate(reVo);
			
			session.setAttribute("eduList", eduOrderedList);
			session.setAttribute("careerList", careerOrderedList);
			session.setAttribute("certiList", certiOrderedList);
		}
		
		result.put("success", (resultCnt > 0) ? "Y" : "N"); // for의 개수보다 크게하려면 어케할까...?
		String callbackMsg = commonUtil.getJsonCallBackString(" ", result);
		System.out.println("callbackMsg::" + callbackMsg);
		
		return callbackMsg;
	}
	
	
}
