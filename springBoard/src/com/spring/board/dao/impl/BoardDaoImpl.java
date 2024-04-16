package com.spring.board.dao.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.board.dao.BoardDao;
import com.spring.board.vo.BoardVo;
import com.spring.board.vo.CareerVo;
import com.spring.board.vo.CertificateVo;
import com.spring.board.vo.ComCodeVo;
import com.spring.board.vo.EducationVo;
import com.spring.board.vo.PageVo;
import com.spring.board.vo.RecruitVo;
import com.spring.board.vo.UserInfoVo;

@Repository
public class BoardDaoImpl implements BoardDao{
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public String selectTest() throws Exception {
		// TODO Auto-generated method stub
		
		String a = sqlSession.selectOne("board.boardList");
		
		return a;
	}
	/**
	 * 
	 * */
	@Override
	public List<BoardVo> selectBoardList(PageVo pageVo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("board.boardList",pageVo);
	}
	
	@Override
	public int selectBoardCnt() throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("board.boardTotal");
	}
	
	@Override
	public BoardVo selectBoard(BoardVo boardVo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("board.boardView", boardVo);
	}
	
	@Override
	public int boardInsert(BoardVo boardVo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.insert("board.boardInsert", boardVo);
	}

	@Override
	public int boardUpdate(BoardVo boardVo) throws Exception {
		return sqlSession.update("board.boardUpdate", boardVo);
	}
	@Override
	public int boardDelete(BoardVo boardVo) throws Exception {
		return sqlSession.delete("board.boardDelete", boardVo);
	}

//==============================================================
	@Override
	public List<ComCodeVo> selectCodeList(ComCodeVo codeVo) throws Exception {
		return sqlSession.selectList("board.codeList", codeVo);
	}
	
// com.user 패키지를 다시 만들어야 하나...?
	@Override
	public int userIdCheck(UserInfoVo userVo) throws Exception {
		return sqlSession.selectOne("user.userIdChk", userVo);
	}
	@Override
	public int userInsert(UserInfoVo userVo) throws Exception {
		return sqlSession.insert("user.userInsert", userVo);
	}
	
	@Override
	public int userLoginCheck(UserInfoVo userVo) throws Exception {
		return sqlSession.selectOne("user.userLoginCheck", userVo);
	}
	@Override
	public UserInfoVo selectUser(UserInfoVo userVo) throws Exception {
		return sqlSession.selectOne("user.selectUser", userVo);
	}
	@Override
	public List<BoardVo> selectMbtiList(PageVo pageVo) throws Exception {
		return sqlSession.selectList("mbti.mbtiList", pageVo);
	}
	@Override
	public String selectMbtiName(String codeId) throws Exception {
		return sqlSession.selectOne("mbti.mbtiName", codeId);
	}
	@Override
	public List<String> mbtiTypeList() throws Exception {
		return sqlSession.selectList("mbti.mbtiTypeList");
	}
	@Override
	public RecruitVo recruitLoginCheck(RecruitVo recruitVo) throws Exception {
		return sqlSession.selectOne("recruit.recruitLoginCheck", recruitVo);
	}
	@Override
	public int insertEducation(EducationVo educationVo) throws Exception {
		return sqlSession.insert("recruit.insertEducation", educationVo);
	}
	@Override
	public int insertCareer(CareerVo careerVo) throws Exception {
		return sqlSession.insert("recruit.insertCareer", careerVo);
	}
	@Override
	public int insertCertificate(CertificateVo certificateVo) throws Exception {
		return sqlSession.insert("recruit.insertCertificate", certificateVo);
	}
	@Override
	public int insertRecruit(RecruitVo recruitVo) throws Exception {
		return sqlSession.insert("recruit.insertRecruit", recruitVo);
	}
	@Override
	public List<EducationVo> selectLoginUserEducation(RecruitVo recruitVo) throws Exception {
		return sqlSession.selectList("recruit.selectLoginUserEducation", recruitVo);
	}
	@Override
	public List<CareerVo> selectLoginUserCareer(RecruitVo recruitVo) throws Exception {
		return sqlSession.selectList("recruit.selectLoginUserCareer", recruitVo);
	}
	@Override
	public List<CertificateVo> selectLoginUserCertificate(RecruitVo recruitVo) throws Exception {
		return sqlSession.selectList("recruit.selectLoginUserCertificate", recruitVo);
	}
	@Override
	public int deleteRecruit(RecruitVo recruitVo) throws Exception {
		return sqlSession.delete("recruit.deleteRecruit", recruitVo);
	}
	
	@Override
	public int deleteEducation(RecruitVo recruitVo) throws Exception {
		return sqlSession.delete("recruit.deleteEducation", recruitVo);
	}
	@Override
	public int deleteCareer(RecruitVo recruitVo) throws Exception {
		return sqlSession.delete("recruit.deleteCareer", recruitVo);
	}
	@Override
	public int deleteCertificate(RecruitVo recruitVo) throws Exception {
		return sqlSession.delete("recruit.deleteCertificate", recruitVo);
	}
	
}
