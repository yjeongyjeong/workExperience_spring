package com.spring.board.service;

import java.util.List;

import com.spring.board.vo.BoardVo;
import com.spring.board.vo.CareerVo;
import com.spring.board.vo.CertificateVo;
import com.spring.board.vo.ComCodeVo;
import com.spring.board.vo.EducationVo;
import com.spring.board.vo.PageVo;
import com.spring.board.vo.RecruitVo;
import com.spring.board.vo.UserInfoVo;

public interface boardService {

	public String selectTest() throws Exception;

	public List<BoardVo> SelectBoardList(PageVo pageVo) throws Exception;

	public BoardVo selectBoard(String boardType, int boardNum) throws Exception;

	public int selectBoardCnt() throws Exception;

	public int boardInsert(BoardVo boardVo) throws Exception;
	
	public int boardUpdate(BoardVo boardVo) throws Exception;
	
	public int boardDelete(BoardVo boardVo) throws Exception;
	//==============================================================
	public List<ComCodeVo> selectCodeList(ComCodeVo codeVo) throws Exception;

	public int userIdCheck(UserInfoVo userVo) throws Exception;
	public int userInsert(UserInfoVo userVo) throws Exception;
	public int userLoginCheck(UserInfoVo userVo) throws Exception;
	public UserInfoVo selectUser(UserInfoVo userVo) throws Exception;

	//==============================================================
	public List<BoardVo> SelectMbtiList(PageVo pageVo) throws Exception;
	public String SelectMbtiName(String codeId) throws Exception;
	public List<String> mbtiTypeList() throws Exception;
	
	//==============================================================
	public RecruitVo recruitLoginCheck(RecruitVo recruitVo) throws Exception;
	public int insertEducation(EducationVo educationVo) throws Exception;
	public int insertCareer(CareerVo careerVo) throws Exception;
	public int insertCertificate(CertificateVo certificateVo) throws Exception;
	public int insertRecruit(RecruitVo recruitVo) throws Exception;

	public List<EducationVo> selectLoginUserEducation(RecruitVo recruitVo) throws Exception;
	public List<CareerVo> selectLoginUserCareer(RecruitVo recruitVo) throws Exception;
	public List<CertificateVo> selectLoginUserCertificate(RecruitVo recruitVo) throws Exception;


}
