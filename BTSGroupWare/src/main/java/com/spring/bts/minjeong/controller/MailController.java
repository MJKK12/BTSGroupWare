package com.spring.bts.minjeong.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.spring.bts.hwanmo.model.EmployeeVO;
import com.spring.bts.minjeong.model.MailVO;
import com.spring.bts.minjeong.service.InterMailService;

@Component
/* XML에서 빈을 만드는 대신에 클래스명 앞에 @Component 어노테이션을 적어주면 해당 클래스는 bean으로 자동 등록된다. 
    그리고 bean의 이름(첫글자는 소문자)은 해당 클래스명이 된다. 
    즉, 여기서 bean의 이름은 boardController 이 된다. 
    여기서는 @Controller 를 사용하므로 @Component 기능이 이미 있으므로 @Component를 명기하지 않아도 BoardController 는 bean 으로 등록되어 스프링컨테이너가 자동적으로 관리해준다. 
*/
@Controller	// Bean 기능 + Controller 기능 ( @Component 를 빼도, 안빼도 무방하다. )
public class MailController {

	// #### 의존객체 목록 #### //
	// Spring 은 항상 Service 가 필요하다! (Controller 는 service를 의존객체로 한다.)
	@Autowired	// Type에 따라 알아서 Bean 을 주입해준다. (service 를 null 로 만들지 않음.)
	private InterMailService service;	// 필요할 땐 사용하고, 필요하지 않을땐 사용하지 않기 (느슨한 결합)
	
	/*
	 * // === #155. 파일업로드 및 다운로드를 해주는 FileManager 클래스 의존객체 주입하기(DI : Dependency
	 * Injection) ===
	 * 
	 * @Autowired // Type에 따라 알아서 Bean 을 주입해준다. private FileManager fileManager; //
	 * type (FileManager) 만 맞으면 다 주입해준다.
	 */	
	
	// 메일 쓰기 폼페이지 요청
	@RequestMapping(value = "/mail/mailWrite.bts", produces = "text/plain; charset=UTF-8")	
	public ModelAndView mailWrite(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		/*
		 * // 로그인 세션 요청하기 HttpSession session = request.getSession(); 
		 * EmployeeVO loginuser = (EmployeeVO)session.getAttribute("loginuser");
		 * 
		 * mav.addObject("loginuser", loginuser);
		 */
		// 메일 쓰기 폼 띄우기		
		mav.setViewName("mailWrite.mail");	// view 단
		
		return mav;
	}
	
	
	// 받은메일함
	@RequestMapping(value = "/mail/mailReceiveList.bts")	
	// URL, 절대경로 contextPath 인 board 뒤의 것들을 가져온다. (확장자.java 와 확장자.xml 은 그 앞에 contextPath 가 빠져있는 것이다.)
	// http://localhost:9090/bts/tiles1/mailList.bts
	public ModelAndView mailList(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {

		// 페이징 처리 한 받은메일함 목록 보여주기 (추후 예정)
		
		// 검색 목록 (추후 예정)
		
		// receiveMailList
		List<MailVO> receiveMailList = service.getReceiveMailList();
		
		mav.addObject("receiveMailList", receiveMailList);		
		mav.setViewName("mailReceiveList.mail");
		
		return mav;
	  //  return "/tiles1/mailList.jsp";	// 아래와 같이 써서 오류가 났음.
	}
	
	
	// 받은메일함 내용 읽기
	@RequestMapping(value = "/mail/mailReceiveDetail.bts")	
	// URL, 절대경로 contextPath 인 board 뒤의 것들을 가져온다. (확장자.java 와 확장자.xml 은 그 앞에 contextPath 가 빠져있는 것이다.)
	// http://localhost:9090/bts/tiles1/mailList.bts
	public String mailReceiveDetail(HttpServletRequest request) {

		// 첨부파일 다운로드 받기	
		
		// 이전글 및 다음글 보여주기
		
		return "mailReceiveDetail.mail";
    //  return "/tiles1/mailList.jsp";	// 아래와 같이 써서 오류가 났음.
	}	
	
	
	// 보낸메일함
	@RequestMapping(value = "/mail/mailSend.bts")	
	public String mailSend(HttpServletRequest request) {
		
		return "mailSendList.mail";
		//	value="/WEB-INF/views/mail/{1}.jsp 페이지를 만들어야 한다.
	}	

	
	// 보낸메일함 내용 읽기
	@RequestMapping(value = "/mail/mailSendDetail.bts")	
	public String mailSendDetail(HttpServletRequest request) {
		
		return "mailSendDetail.mail";
		//	value="/WEB-INF/views/mail/{1}.jsp 페이지를 만들어야 한다.
	}		
		
	
	// 중요메일함
	@RequestMapping(value = "/mail/mailImportant.bts")	
	public String mailImportant(HttpServletRequest request) {
		
		return "mailImportant.mail";
		//	value="/WEB-INF/views/mail/{1}.jsp 페이지를 만들어야 한다.
	}	
	
	// 중요메일함 내용 읽기
	@RequestMapping(value = "/mail/mailImportantDetail.bts")	
	public String mailImportantDetail(HttpServletRequest request) {
		
		return "mailImportantDetail.mail";
		//	value="/WEB-INF/views/mail/{1}.jsp 페이지를 만들어야 한다.
	}		
	
	
	// 임시보관함
	@RequestMapping(value = "/mail/mailTemporary.bts")	
	public String mailTemporary(HttpServletRequest request) {
		
		return "mailTemporary.mail";
		//	value="/WEB-INF/views/mail/{1}.jsp 페이지를 만들어야 한다.
	}	
	
	
	// 임시보관함 내용 읽기
	@RequestMapping(value = "/mail/mailTemporaryDetail.bts")	
	public String mailTemporaryDetail(HttpServletRequest request) {
		
		return "mailTemporaryDetail.mail";
		//	value="/WEB-INF/views/mail/{1}.jsp 페이지를 만들어야 한다.
	}		
	
	
	
	// 예약메일함
	@RequestMapping(value = "/mail/mailReservation.bts")	
	public String mailReservation(HttpServletRequest request) {
		
		return "mailReservation.mail";
		//	value="/WEB-INF/views/mail/{1}.jsp 페이지를 만들어야 한다.
	}	
	
	// 예약메일함 내용 읽기
	@RequestMapping(value = "/mail/mailReservationDetail.bts")	
	public String mailReservationDetail(HttpServletRequest request) {
		
		return "mailReservationDetail.mail";
		//	value="/WEB-INF/views/mail/{1}.jsp 페이지를 만들어야 한다.
	}		
			
	
	// 휴지통 목록 보여주기
	@RequestMapping(value = "/mail/mailRecyclebin.bts")	
	public String mailRecyclebin(HttpServletRequest request) {
		
		return "mailRecyclebin.mail";
		//	value="/WEB-INF/views/mail/{1}.jsp 페이지를 만들어야 한다.
	}	

	// 휴지통 내용 읽기
	@RequestMapping(value = "/mail/mailRecyclebinDetail.bts")	
	public String mailRecyclebinDetail(HttpServletRequest request) {
		
		return "mailRecyclebinDetail.mail";
		//	value="/WEB-INF/views/mail/{1}.jsp 페이지를 만들어야 한다.
	}		
	
	// 휴지통 목록 삭제하기
	@RequestMapping(value = "/mail/mailRecyclebinClear.bts")	
	public String mailRecyclebinClear(HttpServletRequest request) {
		
		return "mailRecyclebinClear.mail";
		//	value="/WEB-INF/views/mail/{1}.jsp 페이지를 만들어야 한다.
	}		
	
}
