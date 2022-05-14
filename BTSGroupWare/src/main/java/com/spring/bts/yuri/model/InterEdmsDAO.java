package com.spring.bts.yuri.model;

import java.util.List;
import java.util.Map;

import com.spring.bts.hwanmo.model.EmployeeVO;

public interface InterEdmsDAO {

	// 로그인된 사원 정보 가져오기
	EmployeeVO getLoginMember(Map<String, String> paraMap);

	// 파일첨부가 없는 전자결재 문서작성
	int edmsAdd(ApprVO apprvo);
	// 파일첨부가 있는 전자결재 문서작성
	int edmsAdd_withFile(ApprVO apprvo);

	// 글 1개 조회하기
	ApprVO getView(Map<String, String> paraMap);

	// 글조회수 1 증가하기 메소드
	void setAddViewcnt(String pk_appr_no);

	// 1개글 수정하기
	int edit(ApprVO apprvo);

	// 1개글 삭제하기
	int del(Map<String, String> paraMap);
	
	// 페이징 처리한 글목록 가져오기(검색이 있든지, 검색이 없든지 모두 다 포함한 것)
	List<ApprVO> edmsListSearchWithPaging(Map<String, String> paraMap);
	
	// 검색어 입력시 자동글 완성하기
	List<String> wordSearchShow(Map<String, String> paraMap);

	// 총 게시물 건수(totalCount) 구하기 - 검색이 있을 때와 검색이 없을 때로 나뉜다.
	int getTotalCount(Map<String, String> paraMap);

	
	
	// 상세부서정보 페이지 사원목록 불러오기 
	List<EmployeeVO> addBook_depInfo_select();

	
	// 승인하기
	int accept(ApprVO apprvo);
}