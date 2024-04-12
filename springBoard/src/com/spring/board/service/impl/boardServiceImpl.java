package com.spring.board.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.board.dao.BoardDao;
import com.spring.board.service.boardService;
import com.spring.board.vo.BoardVo;
import com.spring.board.vo.CareerVo;
import com.spring.board.vo.CertificateVo;
import com.spring.board.vo.ComCodeVo;
import com.spring.board.vo.EducationVo;
import com.spring.board.vo.PageVo;
import com.spring.board.vo.RecruitVo;
import com.spring.board.vo.UserInfoVo;

@Service
public class boardServiceImpl implements boardService{
	
	@Autowired
	BoardDao boardDao;
	
	@Override
	public String selectTest() throws Exception {
		// TODO Auto-generated method stub
		return boardDao.selectTest();
	}
	
	@Override
	public List<BoardVo> SelectBoardList(PageVo pageVo) throws Exception {
		// TODO Auto-generated method stub
		
		return boardDao.selectBoardList(pageVo);
	}
	
	@Override
	public int selectBoardCnt() throws Exception {
		// TODO Auto-generated method stub
		return boardDao.selectBoardCnt();
	}
	
	@Override
	public BoardVo selectBoard(String boardType, int boardNum) throws Exception {
		// TODO Auto-generated method stub
		BoardVo boardVo = new BoardVo();
		
		boardVo.setBoardType(boardType);
		boardVo.setBoardNum(boardNum);
		
		return boardDao.selectBoard(boardVo);
	}
	
	@Override
	public int boardInsert(BoardVo boardVo) throws Exception {
		// TODO Auto-generated method stub
		return boardDao.boardInsert(boardVo);
	}

	@Override
	public int boardUpdate(BoardVo boardVo) throws Exception {
		return boardDao.boardUpdate(boardVo);
	}

	@Override
	public int boardDelete(BoardVo boardVo) throws Exception {
		return boardDao.boardDelete(boardVo);
	}

	@Override
	public List<ComCodeVo> selectCodeList(ComCodeVo codeVo) throws Exception {
		return boardDao.selectCodeList(codeVo);
	}

	@Override
	public int userIdCheck(UserInfoVo userVo) throws Exception {
		return boardDao.userIdCheck(userVo);
	}

	@Override
	public int userInsert(UserInfoVo userVo) throws Exception {
		return boardDao.userInsert(userVo);
	}

	@Override
	public int userLoginCheck(UserInfoVo userVo) throws Exception {
		return boardDao.userLoginCheck(userVo);
	}

	@Override
	public UserInfoVo selectUser(UserInfoVo userVo) throws Exception {
		return boardDao.selectUser(userVo);
	}

	@Override
	public List<BoardVo> SelectMbtiList(PageVo pageVo) throws Exception {
		return boardDao.selectMbtiList(pageVo);
	}

	@Override
	public String SelectMbtiName(String codeId) throws Exception {
		return boardDao.selectMbtiName(codeId);
	}

	@Override
	public List<String> mbtiTypeList() throws Exception {
		return boardDao.mbtiTypeList();
	}

	@Override
	public RecruitVo recruitLoginCheck(RecruitVo recruitVo) throws Exception {
		return boardDao.recruitLoginCheck(recruitVo);
	}

	@Override
	public int insertEducation(EducationVo educationVo) throws Exception {
		return boardDao.insertEducation(educationVo);
	}

	@Override
	public int insertCareer(CareerVo careerVo) throws Exception {
		return boardDao.insertCareer(careerVo);
	}

	@Override
	public int insertCertificate(CertificateVo certificateVo) throws Exception {
		return boardDao.insertCertificate(certificateVo);
	}

	@Override
	public int insertRecruit(RecruitVo recruitVo) throws Exception {
		return boardDao.insertRecruit(recruitVo);
	}
	
}
