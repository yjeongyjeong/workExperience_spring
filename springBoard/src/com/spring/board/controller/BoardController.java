package com.spring.board.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;


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
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.board.HomeController;
import com.spring.board.service.boardService;
import com.spring.board.vo.BoardVo;
import com.spring.board.vo.PageVo;
import com.spring.common.CommonUtil;

@Controller
public class BoardController {
	
	@Autowired 
	boardService boardService;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@RequestMapping(value = "/board/boardList.do", method = RequestMethod.GET)
	public String boardList(Locale locale, Model model,PageVo pageVo) throws Exception{
		
		List<BoardVo> boardList = new ArrayList<BoardVo>();
		
		int page = 1;
		int totalCnt = 0;
		
		if(pageVo.getPageNo() == 0){
			pageVo.setPageNo(page);;
		}
		
		boardList = boardService.SelectBoardList(pageVo);
		totalCnt = boardService.selectBoardCnt();
		
		model.addAttribute("boardList", boardList);
		model.addAttribute("totalCnt", totalCnt);
		model.addAttribute("pageNo", page);
		
		return "board/boardList";
	}
	
	@RequestMapping(value = "/board/{boardType}/{boardNum}/boardView.do", method = RequestMethod.GET)
	public String boardView(Locale locale, Model model
			,@PathVariable("boardType")String boardType
			,@PathVariable("boardNum")int boardNum) throws Exception{
		
		BoardVo boardVo = new BoardVo();
		
		
		boardVo = boardService.selectBoard(boardType,boardNum);
		
		model.addAttribute("boardType", boardType);
		model.addAttribute("boardNum", boardNum);
		model.addAttribute("board", boardVo);
		
		return "board/boardView";
	}
	
	@RequestMapping(value = "/board/boardWrite.do", method = RequestMethod.GET)
	public String boardWrite(Locale locale, Model model) throws Exception{
		
		
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
	public String boardWriteAction( @RequestBody List<BoardVo> boardList, Locale locale) throws Exception{
		
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
		
		List<BoardVo> boardVoList = mapper.readValue(jsonBoardList, new TypeReference<List<BoardVo>>() {});

		//boardVo라는 객체에 전부 데이터를 담아줌(알아서 맵핑)
	    for (BoardVo boardVo : boardVoList) {
	        System.out.println("게시글 정보: " + boardVo); //com.spring.board.vo.BoardVo@4c547402이렇게 나오네...
	        resultCnt = boardService.boardInsert(boardVo); 
	        System.out.println("resultCnt >> " + resultCnt);
	    }

		result.put("success", (resultCnt > 0)?"Y":"N");		
		String callbackMsg = commonUtil.getJsonCallBackString(" ",result);
		System.out.println("callbackMsg::"+callbackMsg);
		
		return callbackMsg;
	}	
	
//requestMapping을 클래스 위에 써서 "/board"를 공통으로 갖게 만들고 @GetMapping이나 @PostMapping을 사용해줘도 괜찮다~
	
	@RequestMapping(value = "/board/{boardType}/{boardNum}/boardModify.do", method = RequestMethod.GET)
	public String boardModify(Locale locale, Model model
			,@PathVariable("boardType")String boardType
			,@PathVariable("boardNum") int boardNum) throws Exception{
		
		System.out.println("========================get========================");

		System.out.println(boardType);
		System.out.println(boardNum);
		
		BoardVo boardVo = new BoardVo();
		boardVo = boardService.selectBoard(boardType,boardNum);
		System.out.println(boardVo.toString());
		
		model.addAttribute("boardType", boardType);
		model.addAttribute("boardNum", boardNum);
		model.addAttribute("board", boardVo);
		return "board/boardModify";
	}
	
	
	@RequestMapping(value = "/board/boardModifyAction.do", method = RequestMethod.POST)
	@ResponseBody
	public String boardModifyAction(Locale locale, BoardVo boardVo, Model model) throws Exception{
		
		System.out.println("=========================post=======================");
		System.out.println("boardVo >>> " + boardVo.toString()); 
		//boardType에서 null값 에러 발생.. 왜냐면 쿼리스트링에서 가져오지도 않았고 hidden으로 가져오지도 않았기 때문
		//쿼리스트링 귀찮아서 그냥 hidden으로 가져옴
		
		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();
		
		int resultCnt = boardService.boardUpdate(boardVo);
		System.out.println("resultCnt >>>>>>>>>>>>>>>>>> " + resultCnt);
		//영향받은 행의 개수이므로 양수면 성공인건가?
		result.put("success", (resultCnt > 0)?"Y":"N");
		
		String callbackMsg = commonUtil.getJsonCallBackString(" ",result);
		
		System.out.println("callbackMsg::"+callbackMsg);
		
		return callbackMsg;
	}
	
	
	@RequestMapping(value = "/board/boardRemoveAction.do", method = RequestMethod.POST)
	@ResponseBody //없으면 json데이터를 인식못하는 것 같음...? callbackMsg 반환이 안됨
	public String boardRemove(Locale locale, BoardVo boardVo ,Model model) throws Exception{
		
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
		result.put("success", (resultCnt > 0)?"Y":"N");
		
		String callbackMsg = commonUtil.getJsonCallBackString(" ",result);
		
		System.out.println("callbackMsg::"+callbackMsg);
		System.out.println("삭제된 번호 >> " + boardVo.getBoardNum());
		
		model.addAttribute("msg", "게시글이 삭제되었습니다.");

		return callbackMsg;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
//==========================================================================================	
	
	
//	List에서 조회하는 경우
	@RequestMapping(value = "/board/boardSearch.do", method = RequestMethod.GET)
	public String boardSearchAction(Locale locale, Model model, PageVo pageVo) throws Exception{
		
		List<BoardVo> boardList = new ArrayList<BoardVo>();
		
		int page = 1;
		int totalCnt = 0;
		
		if(pageVo.getPageNo() == 0){
			pageVo.setPageNo(page);;
		}
		
		model.addAttribute("totalCnt", totalCnt);
		model.addAttribute("pageNo", page);
		model.addAttribute("list", "search");
		return "board/boardSearch";
	}
	
	@RequestMapping(value = "/board/boardSearchAction.do", method = RequestMethod.POST)
	@ResponseBody
	public String boardSearchAction( @RequestBody List<BoardVo> boardList, Locale locale) throws Exception{
		
		System.out.println("현재 게시글 board >>>>>>>>>>>>>>>>> " + boardList.toString());
//		[{boardType=a01}, {boardType=a02}, {boardType=a03}, {boardType=a04}] 근데 굳이 이렇게 안받아도 됨..

		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();		
		int resultCnt = -1;

		ObjectMapper mapper = new ObjectMapper();
		String jsonBoardList = mapper.writeValueAsString(boardList);
		
		List<BoardVo> boardVoList = mapper.readValue(jsonBoardList, new TypeReference<List<BoardVo>>() {});
//		여기서는 검색메소드.. %같은 애들 나와야할듯?

		int page = 1;
		int totalCnt = 0;
		
		PageVo pageVo = new PageVo();
		
		if(pageVo.getPageNo() == 0){
			pageVo.setPageNo(page);;
		}
		
		//boardVo라는 객체에 전부 데이터를 담아줌(알아서 맵핑)
//	    for (BoardVo boardVo : boardVoList) {
//	        System.out.println("게시글 정보: " + boardVo); //com.spring.board.vo.BoardVo@4c547402이렇게 나오네...
//	        resultCnt = boardService.searchBoardList(pageVo); 
//	        System.out.println("resultCnt >> " + resultCnt);
//	    }

		result.put("success", (resultCnt > 0)?"Y":"N");		
		String callbackMsg = commonUtil.getJsonCallBackString(" ",result);
		System.out.println("callbackMsg::"+callbackMsg);
		
		return callbackMsg;
	}	
}
