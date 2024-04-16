package com.spring.board.dao;

import java.util.List;

import com.spring.board.vo.BoardVo;
import com.spring.board.vo.CareerVo;
import com.spring.board.vo.CertificateVo;
import com.spring.board.vo.ComCodeVo;
import com.spring.board.vo.EducationVo;
import com.spring.board.vo.PageVo;
import com.spring.board.vo.RecruitVo;
import com.spring.board.vo.UserInfoVo;

public interface BoardDao {

	public String selectTest() throws Exception;

	public List<BoardVo> selectBoardList(PageVo pageVo) throws Exception;

	public BoardVo selectBoard(BoardVo boardVo) throws Exception;

	public int selectBoardCnt() throws Exception;

	public int boardInsert(BoardVo boardVo) throws Exception;
	
	//영향받은 행의 개수를 반환하는데 굳이 반환을 해야하나 싶은 마음... 0일수도 있는 거 아닌가? 
//	일단 void로 진행.. 하려 했는데 json 바꾸기 귀찮아져서 그냥 int반환으로 다시 변경..ㅎㅎ
	public int boardUpdate(BoardVo boardVo) throws Exception;
	
	public int boardDelete(BoardVo boardVo) throws Exception;
	
//	============================================
	public List<ComCodeVo> selectCodeList(ComCodeVo codeVo) throws Exception;

	public int userIdCheck(UserInfoVo userVo) throws Exception;
	public int userInsert(UserInfoVo userVo) throws Exception;
	public int userLoginCheck(UserInfoVo userVo) throws Exception;
	public UserInfoVo selectUser(UserInfoVo userVo) throws Exception;
//	============================================
	public List<BoardVo> selectMbtiList(PageVo pageVo) throws Exception;
	public String selectMbtiName(String codeId) throws Exception;
	public List<String> mbtiTypeList() throws Exception;
//	============================================
	public RecruitVo recruitLoginCheck(RecruitVo recruitVo) throws Exception;
	public int insertEducation(EducationVo educationVo) throws Exception;
	public int insertCareer(CareerVo careerVo) throws Exception;
	public int insertCertificate(CertificateVo certificateVo) throws Exception;
	public int insertRecruit(RecruitVo recruitVo) throws Exception;
	
	public int deleteRecruit(RecruitVo recruitVo) throws Exception;
	public int deleteEducation(RecruitVo recruitVo) throws Exception;
	public int deleteCareer(RecruitVo recruitVo) throws Exception;
	public int deleteCertificate(RecruitVo recruitVo) throws Exception;
	
	public List<EducationVo> selectLoginUserEducation(RecruitVo recruitVo) throws Exception;
	public List<CareerVo> selectLoginUserCareer(RecruitVo recruitVo) throws Exception;
	public List<CertificateVo> selectLoginUserCertificate(RecruitVo recruitVo) throws Exception;
	
}
