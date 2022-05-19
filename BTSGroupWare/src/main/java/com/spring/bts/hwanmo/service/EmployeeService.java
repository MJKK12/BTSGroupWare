package com.spring.bts.hwanmo.service;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.bts.common.AES256;
import com.spring.bts.hwanmo.model.EmployeeVO;
import com.spring.bts.hwanmo.model.InterEmployeeDAO;

//=== #31. Service 선언 === 
//트랜잭션 처리를 담당하는곳 , 업무를 처리하는 곳, 비지니스(Business)단
@Service
public class EmployeeService implements InterEmployeeService {

	@Autowired
	private InterEmployeeDAO empDAO; 
	
	// === #45. 양방향 암호화 알고리즘인 AES256 를 사용하여 복호화 하기 위한 클래스 의존객체 주입하기(DI: Dependency Injection) ===
	@Autowired
	private AES256 aes;
	// Type 에 따라 Spring 컨테이너가 알아서 bean 으로 등록된 com.spring.board.common.AES256 의 bean 을  aes 에 주입시켜준다. 
	// 그러므로 aes 는 null 이 아니다.
	// com.spring.board.common.AES256 의 bean 은 /webapp/WEB-INF/spring/appServlet/servlet-context.xml 파일에서 bean 으로 등록시켜주었음.
	
	
	
	// ID 중복검사 (tbl_member 테이블에서 userid 가 존재하면 true를 리턴해주고, userid 가 존재하지 않으면 false를 리턴한다)
	@Override
	public boolean idDuplicateCheck(String pk_emp_no) {
		boolean isExist = empDAO.idDuplicateCheck(pk_emp_no);
		return isExist;
	}

	// email 중복검사 (tbl_member 테이블에서 email 이 존재하면 true를 리턴해주고, email 이 존재하지 않으면 false를 리턴한다) 
	@Override
	public boolean emailDuplicateCheck(String uq_email) {
		
		try {
			uq_email = aes.encrypt(uq_email); // 이메일을 암호화
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		}
		
		boolean isExist = empDAO.emailDuplicateCheck(uq_email);
		return isExist;
	}

	// 사원 가입하기
	@Override
	public int registerMember(EmployeeVO empvo) throws SQLException {
		int n = empDAO.registerMember(empvo);
		return n;
	}

	// 아이디 찾기
	@Override
	public String findEmpNo(Map<String, String> paraMap) {
		String pk_emp_no = empDAO.findEmpNo(paraMap);
		return pk_emp_no;
	}

	// 사용자가 존재하는지 확인
	@Override
	public boolean isUserExist(Map<String, String> paraMap) {
		boolean isUserExist = empDAO.isUserExist(paraMap);
		return isUserExist;
	} // end of public boolean isUserExist(Map<String, String> paraMap) {})------------
	
	// 비밀번호 변경
	@Override
	public int pwdUpdate(Map<String, String> paraMap) {
		int n = empDAO.pwdUpdate(paraMap);
		return n;
	}

	// 원시인(생일구하기)
	@Override
	public Map<String, String> getBirthday(int pk_emp_no) {
		Map<String, String> paraMap = empDAO.getBirthday(pk_emp_no);
		return paraMap;
	}

	// 프로필 사진 업데이트
	@Override
	public int updateEmpImg(EmployeeVO empVO) {
		int n = empDAO.updateEmpImg(empVO);
		return n;
	}

	// 회원정보 수정
	@Override
	public int updateMember(EmployeeVO empvo) {
		int n = empDAO.updateMember(empvo);
		return n;
	}

	// 회원정보 받아오기
	@Override
	public List<Map<String, Object>> getEmpInfo(int pk_emp_no) {
		List<Map<String, Object>> empList = empDAO.getEmpInfo(pk_emp_no);
		return empList;
	}

	@Override
	public EmployeeVO getLoginMember(Map<String, String> paraMap) {
		
		EmployeeVO loginuser = empDAO.getLoginMember(paraMap);
		
		// === #48. aes 의존객체를 사용하여 로그인 되어진 사용자(loginuser)의 이메일 값을 복호화 하도록 한다. === 
	    //          또한 암호변경 메시지와 휴면처리 유무 메시지를 띄우도록 업무처리를 하도록 한다.
		if(loginuser != null && loginuser.getPwdchangegap() >= 3 ) {
			// 마지막으로 암호를 변경한 날짜가 현재시각으로부터 3개월이 지났으면
			loginuser.setRequirePwdChange(true); // 로그인시 암호를 변경하라는 alert를 띄우도록 한다.
		}
		/*
		if(loginuser != null && loginuser.getLastlogingap() >= 12) {
			// 마지막으로 로그인한지가 12개월이 지났으면 휴면으로 지정
			loginuser.setIdle(1);
			
			// === tbl_member 테이블의 idle 컬럼의 값을 1로 변경하기 === //
			int n = dao.updateIdle(paraMap.get("userid"));
		}
		*/
		if(loginuser != null) {
			
			String email = "";
			
			try {
				email = aes.decrypt(loginuser.getUq_email()); // 이메일을 복호화
			} catch (UnsupportedEncodingException | GeneralSecurityException e) {
				e.printStackTrace();
			}
			
			loginuser.setUq_email(email); // 복호화된 값을 다시 넣어줌	
		}
		
		return loginuser;
	}

}
