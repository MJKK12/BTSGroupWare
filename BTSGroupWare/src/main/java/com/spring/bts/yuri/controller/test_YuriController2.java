package com.spring.bts.yuri.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

//=== 컨트롤러 선언 === //
@Component
/* 
	XML에서 빈을 만드는 대신에 클래스명 앞에 @Component 어노테이션을 적어주면 해당 클래스는 bean으로 자동 등록된다. 
	그리고 bean의 이름(첫글자는 소문자)은 해당 클래스명이 된다. 
	즉, 여기서 bean의 이름은 boardController 이 된다. 
	여기서는 @Controller 를 사용하므로 @Component 기능이 이미 있으므로 @Component를 명기하지 않아도 BoardController 는 bean 으로 등록되어 스프링컨테이너가 자동적으로 관리해준다. 
*/
@Controller /* Bean + controller 기능을 모듀 포함 */
public class test_YuriController2 {

	
	// 주소록 테스트
	@RequestMapping(value="/addBook/addbook_main.bts")
	public ModelAndView addbook_main(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		mav.setViewName("addbook_main.addBook");
		// /WEB-INF/views/addBook/{1}.jsp
		// /WEB-INF/views/addBook/addbook_main.jsp 페이지를 만들어야 한다.
		return mav;
	}
	
	// 주소록 테스트2
	@RequestMapping(value="/addBook/addbook_teladd.bts")
	public ModelAndView addbook_teladd(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		mav.setViewName("addbook_teladd.addBook");
		// /WEB-INF/views/addBook/{1}.jsp
		// /WEB-INF/views/addBook/addbook_teladd.jsp 페이지를 만들어야 한다.
		return mav;
	}
	
	// === 전자결재 테스트 페이지 === //
	@RequestMapping(value="/edms/edmsTest.bts")
	public ModelAndView edmsTest(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {

		mav.setViewName("edms_test.edms");
		// /WEB-INF/views/edms/{1}.jsp
		// /WEB-INF/views/edms/edms_test.jsp 페이지를 만들어야 한다.
		return mav;
		
	}
	
	// === 전자결재 홈 페이지 === //
	@RequestMapping(value="/edms/edmsHome.bts")
	public ModelAndView edmsHome(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {

		mav.setViewName("edmsHome.edms");
		// /WEB-INF/views/edms/{1}.jsp
		// /WEB-INF/views/edms/edmsHome.jsp 페이지를 만들어야 한다.
		return mav;
		
	}


	// === 전자결재 문서작성 페이지 === //
	@RequestMapping(value="/edms/edmsAdd.bts", produces="text/plain;charset=UTF-8")
	public ModelAndView addEdms(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
	//	getCurrentURL(request); // 로그아웃을 했을 때  현재 보이던 그 페이지로 그대로 돌아가기 위한 메소드 호출
		// 위의 문장을 주석처리하고 게시판 - 글쓰기 - 로그인 - 로그아웃 을 하면  goBackURL이 없으므로 시작페이지로 간다!
		
		mav.setViewName("edmsAdd.edms");
		// /WEB-INF/views/edms/{1}.jsp
		// /WEB-INF/views/edms/edmsAdd.jsp 페이지를 만들어야 한다.
		return mav;
	}
	
	
	// === bts 내문서함 페이지 === //
	@RequestMapping(value="/edms/edmsMydoc.bts", produces="text/plain;charset=UTF-8")
	public ModelAndView edmsMydoc(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
	//	getCurrentURL(request); // 로그아웃을 했을 때  현재 보이던 그 페이지로 그대로 돌아가기 위한 메소드 호출
		// 위의 문장을 주석처리하고 게시판 - 글쓰기 - 로그인 - 로그아웃 을 하면  goBackURL이 없으므로 시작페이지로 간다!
		
		mav.setViewName("edmsMydoc.edms");
		// /WEB-INF/views/edms/{1}.jsp
		// /WEB-INF/views/edms/edmsMydoc.jsp 페이지를 만들어야 한다.
		return mav;
	}
	
	
	// === bts 결재하기 페이지 === //
	@RequestMapping(value="/edms/edmsApprove.bts", produces="text/plain;charset=UTF-8")
	public ModelAndView edmsApprove(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
	//	getCurrentURL(request); // 로그아웃을 했을 때  현재 보이던 그 페이지로 그대로 돌아가기 위한 메소드 호출
		// 위의 문장을 주석처리하고 게시판 - 글쓰기 - 로그인 - 로그아웃 을 하면  goBackURL이 없으므로 시작페이지로 간다!
		
		mav.setViewName("edmsApprove.edms");
		// /WEB-INF/views/edms/{1}.jsp
		// /WEB-INF/views/edms/edmsApprove.jsp 페이지를 만들어야 한다.
		return mav;
	}


}