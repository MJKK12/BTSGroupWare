package com.spring.bts.moongil.controller;
import java.io.File;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.spring.bts.common.FileManager;
import com.spring.bts.common.MyUtil;
import com.spring.bts.moongil.model.BoardVO;
import com.spring.bts.hwanmo.model.EmployeeVO;
import com.spring.bts.moongil.service.InterBoardService;

//=== #30. 컨트롤러 선언 === // 
@Component
/* XML에서 빈을 만드는 대신에 클래스명 앞에 @Component 어노테이션을 적어주면 해당 클래스는 bean으로 자동 등록된다. 
그리고 bean의 이름(첫글자는 소문자)은 해당 클래스명이 된다. 
즉, 여기서 bean의 이름은  btsController 이 된다. 
여기서는 @Controller 를 사용하므로 @Component 기능이 이미 있으므로 @Component를 명기하지 않아도 BtsController 는 bean 으로 등록되어 스프링컨테이너가 자동적으로 관리해준다. 
*/
@Controller
public class BoardController {

	@Autowired
	private InterBoardService service;
	
	// === #155. 파일업로드 및 다운로드를 해주는 FileManager 클래스 의존객체 주입하기(DI : Dependency Injection) ===  
		@Autowired     // Type에 따라 알아서 Bean 을 주입해준다.
		private FileManager fileManager;
	
	
	
	@RequestMapping(value = "/board/main.bts")      // URL, 절대경로 contextPath 인 board 뒤의 것들을 가져온다. (확장자.java 와 확장자.xml 은 그 앞에 contextPath 가 빠져있는 것이다.)
    public String board_main(HttpServletRequest request) {

		      
	       return "board_main.board";
	}

	
	// --- 게시판 시작 ---  -----------------
	@RequestMapping(value = "/board/list.bts")      // URL, 절대경로 contextPath 인 board 뒤의 것들을 가져온다. (확장자.java 와 확장자.xml 은 그 앞에 contextPath 가 빠져있는 것이다.)
	public ModelAndView list(ModelAndView mav, HttpServletRequest request) {
		
		///////////////////////////////////
		
		getCurrentURL(request); // 로그아웃을 했을 때 현재 보이던 그 페이지로 그대로 돌아가기  위한 메소드 호출 
		
		List<BoardVO> boardList = null;
		
		//////////////////////////////////////////////////////
		// === #69. 글조회수(readCount)증가 (DML문 update)는
		//          반드시 목록보기에 와서 해당 글제목을 클릭했을 경우에만 증가되고,
		//          웹브라우저에서 새로고침(F5)을 했을 경우에는 증가가 되지 않도록 해야 한다.
		//          이것을 하기 위해서는 session 을 사용하여 처리하면 된다.
		HttpSession session = request.getSession();
		session.setAttribute("readCountPermission", "yes");

		String searchType = request.getParameter("searchType");
		String searchWord = request.getParameter("searchWord");
		String str_currentShowPageNo = request.getParameter("currentShowPageNo");
		
		if(searchType == null || (!"subject".equals(searchType) && !"name".equals(searchType)) ) {
			searchType = "";
		}
		
		if(searchWord == null || "".equals(searchWord) || searchWord.trim().isEmpty() ) {
			searchWord = "";
		}
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("searchType", searchType);
		paraMap.put("searchWord", searchWord);
		
		// 먼저 총 게시물 건수(totalCount)를 구해와야 한다.
		// 총 게시물 건수(totalCount)는 검색조건이 있을 때와 없을때로 나뉘어진다. 
		int totalCount = 0;        // 총 게시물 건수
		int sizePerPage = 10;       // 한 페이지당 보여줄 게시물 건수 
		int currentShowPageNo = 0; // 현재 보여주는 페이지번호로서, 초기치로는 1페이지로 설정함.
		int totalPage = 0;         // 총 페이지수(웹브라우저상에서 보여줄 총 페이지 개수, 페이지바)
		
		int startRno = 0; // 시작 행번호
		int endRno = 0;   // 끝 행번호
		 
		// 총 게시물 건수(totalCount)
		totalCount = service.getTotalCount(paraMap);
	//	System.out.println("~~~~~ 확인용 totalCount : " + totalCount);

		
		// 만약에 총 게시물 건수(totalCount)가 127개 이라면
		// 총 페이지수(totalPage)는 13개가 되어야 한다.
		
		totalPage = (int) Math.ceil((double)totalCount/sizePerPage);
		// (double)127/10 ==> 12.7 ==> Math.ceil(12.7) ==> 13.0 ==> (int)13.0 ==> 13
		// (double)120/10 ==> 12.0 ==> Math.ceil(12.0) ==> 12.0 ==> (int)12.0 ==> 12
		
		if(str_currentShowPageNo == null) {
			// 게시판에 보여지는 초기화면
			currentShowPageNo = 1;
		}
		else {
			try {
				currentShowPageNo = Integer.parseInt(str_currentShowPageNo); 
				if( currentShowPageNo < 1 || currentShowPageNo > totalPage) {
					currentShowPageNo = 1;
				}
			} catch(NumberFormatException e) {
				currentShowPageNo = 1;
			}
		}
		
		// **** 가져올 게시글의 범위를 구한다.(공식임!!!) **** 
		/*
		     currentShowPageNo      startRno     endRno
		    --------------------------------------------
		         1 page        ===>    1           10
		         2 page        ===>    11          20
		         3 page        ===>    21          30
		         4 page        ===>    31          40
		         ......                ...         ...
		 */
		
		startRno = ((currentShowPageNo - 1) * sizePerPage) + 1;
		endRno = startRno + sizePerPage - 1;

		
		paraMap.put("startRno", String.valueOf(startRno));
		paraMap.put("endRno", String.valueOf(endRno));
		
		boardList = service.boardListSearchWithPaging(paraMap);
		// 페이징 처리한 글목록 가져오기(검색이 있든지, 검색이 없든지 모두 다 포함 한 것)
		
		// 아래는 검색대상 컬럼과 검색어를 유지시키기 위한 것임.
		if( !"".equals(searchType) && !"".equals(searchWord) ) {
			mav.addObject("paraMap", paraMap);
		}
		
		
		// === #121. 페이지바 만들기 === //
		int blockSize = 10;
		// blockSize 는 1개 블럭(토막)당 보여지는 페이지번호의 개수이다.
		/*
			        1  2  3  4  5  6  7  8  9 10 [다음][마지막]  -- 1개블럭
			[맨처음][이전]  11 12 13 14 15 16 17 18 19 20 [다음][마지막]  -- 1개블럭
			[맨처음][이전]  21 22 23
		*/
		
		int loop = 1;
		/*
	    	loop는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 개수[ 지금은 10개(== blockSize) ] 까지만 증가하는 용도이다.
	    */
		
		int pageNo = ((currentShowPageNo - 1)/blockSize) * blockSize + 1;
		// *** !! 공식이다. !! *** //
		
	/*
	    1  2  3  4  5  6  7  8  9  10  -- 첫번째 블럭의 페이지번호 시작값(pageNo)은 1 이다.
	    11 12 13 14 15 16 17 18 19 20  -- 두번째 블럭의 페이지번호 시작값(pageNo)은 11 이다.
	    21 22 23 24 25 26 27 28 29 30  -- 세번째 블럭의 페이지번호 시작값(pageNo)은 21 이다.
	    
	    currentShowPageNo         pageNo
	   ----------------------------------
	         1                      1 = ((1 - 1)/10) * 10 + 1
	         2                      1 = ((2 - 1)/10) * 10 + 1
	         3                      1 = ((3 - 1)/10) * 10 + 1
	         4                      1
	         5                      1
	         6                      1
	         7                      1 
	         8                      1
	         9                      1
	         10                     1 = ((10 - 1)/10) * 10 + 1
	        
	         11                    11 = ((11 - 1)/10) * 10 + 1
	         12                    11 = ((12 - 1)/10) * 10 + 1
	         13                    11 = ((13 - 1)/10) * 10 + 1
	         14                    11
	         15                    11
	         16                    11
	         17                    11
	         18                    11 
	         19                    11 
	         20                    11 = ((20 - 1)/10) * 10 + 1
	         
	         21                    21 = ((21 - 1)/10) * 10 + 1
	         22                    21 = ((22 - 1)/10) * 10 + 1
	         23                    21 = ((23 - 1)/10) * 10 + 1
	         ..                    ..
	         29                    21
	         30                    21 = ((30 - 1)/10) * 10 + 1
	*/
		
		
		String pageBar = "<ul style='list-style: none;'>";
		String url = "list.bts";
		
		// === [맨처음][이전] 만들기 === //
		if(pageNo != 1) {
			pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo=1'>[맨처음]</a></li>";
			pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+(pageNo-1)+"'>[이전]</a></li>";
		}
		
		while( !(loop > blockSize || pageNo > totalPage) ) {
			
			if(pageNo == currentShowPageNo) {
				pageBar += "<li style='display:inline-block; width:30px; font-size:12pt; border:solid 1px gray; color:red; padding:2px 4px;'>"+pageNo+"</li>";  
			}
			else {
				pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>"; 
			}
			
			loop++;
			pageNo++;
			
		}// end of while-----------------------
		
		
		// === [다음][마지막] 만들기 === //
		if( pageNo <= totalPage ) {
			pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+pageNo+"'>[다음]</a></li>";
			pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+totalPage+"'>[마지막]</a></li>"; 
		}
		
		pageBar += "</ul>";
		
		mav.addObject("pageBar", pageBar);
		
		
		// === #123. 페이징 처리되어진 후 특정 글제목을 클릭하여 상세내용을 본 이후
		//           사용자가 목록보기 버튼을 클릭했을때 돌아갈 페이지를 알려주기 위해
		//           현재 페이지 주소를 뷰단으로 넘겨준다.
		String gobackURL = MyUtil.getCurrentURL(request);
	//	System.out.println("~~~~~ 확인용 gobackURL : " + gobackURL);
		/*
		 	~~~~~ 확인용 gobackURL : /list.action?searchType=&searchWord=&currentShowPageNo=2
			~~~~~ 확인용 gobackURL : /list.action?searchType=&searchWord=&currentShowPageNo=3
			~~~~~ 확인용 gobackURL : /list.action?searchType=subject&searchWord=j
			~~~~~ 확인용 gobackURL : /list.action?searchType=subject&searchWord=j&currentShowPageNo=2 
		 */
		mav.addObject("gobackURL", gobackURL.replaceAll("&", " "));
		
		// ==== 페이징 처리를 한 검색어가 있는 전체 글목록 보여주기 끝 ====
		///////////////////////////////////////////////////////////////
		
		
		mav.addObject("boardList", boardList);
		
		/////////////////////////////////////
		
		
		mav.setViewName("board/list.board");
		//  /WEB-INF/views/tiles1/board/list.jsp 파일을 생성한다.
		
		return mav;
	
	}
	
	@RequestMapping(value="board/view_2.bts")
	public ModelAndView view_2(ModelAndView mav, HttpServletRequest request) {
		
		getCurrentURL(request); // 로그아웃을 했을 때 현재 보이던 그 페이지로 그대로 돌아가기  위한 메소드 호출 
		
		// 조회하고자 하는 글번호 받아오기 
	 	String seq = request.getParameter("seq");
	 	
	 	String searchType = request.getParameter("searchType");
	 	String searchWord = request.getParameter("searchWord");
	 	String gobackURL = request.getParameter("gobackURL");
	 	/*
	 	System.out.println("~~~~ view2 의 searchType : " + searchType);
	    System.out.println("~~~~ view2 의 searchWord : " + searchWord);
	    System.out.println("~~~~ view2 의 gobackURL : " + gobackURL);
	 	*/
	 	
	 	HttpSession session = request.getSession();
		session.setAttribute("readCountPermission", "yes");
	 	
		try {
	         searchWord = URLEncoder.encode(searchWord, "UTF-8"); // 한글이 웹브라우저 주소창에서 사용되어질때 한글이 ? 처럼 안깨지게 하려고 하는 것임.  
	         gobackURL = URLEncoder.encode(gobackURL, "UTF-8");   // 한글이 웹브라우저 주소창에서 사용되어질때 한글이 ? 처럼 안깨지게 하려고 하는 것임.
	        /* 
	         System.out.println("~~~~ view2 의 URLEncoder.encode(searchWord, \"UTF-8\") : " + searchWord);
	         System.out.println("~~~~ view2 의 URLEncoder.encode(gobackURL, \"UTF-8\") : " + gobackURL);
	         
	         System.out.println(URLDecoder.decode(searchWord, "UTF-8")); // URL인코딩 되어진 한글을 원래 한글모양으로 되돌려 주는 것임. 
	         System.out.println(URLDecoder.decode(gobackURL, "UTF-8"));  // URL인코딩 되어진 한글을 원래 한글모양으로 되돌려 주는 것임. 
	         */
	      } catch (UnsupportedEncodingException e) {
	         e.printStackTrace();
	      } 
		
	 	mav.setViewName("redirect:/board/view.bts?seq="+seq+"&searchType="+searchType+"&searchWord="+searchWord+"&gobackURL="+gobackURL);
	 	
		return mav;
	}	
	
	// === 게시판 글쓰기 ====
	// === #51. 게시판 글쓰기 폼페이지 요청 === //
		@RequestMapping(value="/board/write.bts")
		public ModelAndView requiredLogin_add(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		//	getCurrentURL(request); // 로그아웃을 했을 때 현재 보이던 그 페이지로 그대로 돌아가기  위한 메소드 호출 
			
			// === #142. 답변글쓰기가 추가된 경우 시작 === //
			String fk_seq = request.getParameter("fk_seq");
			String groupno = request.getParameter("groupno");
			String depthno = request.getParameter("depthno");
			String subject = "[답변] "+request.getParameter("subject");
			
			if(fk_seq == null) {
				fk_seq = "";
			}
			
			mav.addObject("fk_seq", fk_seq);
			mav.addObject("groupno", groupno);
			mav.addObject("depthno", depthno);
			mav.addObject("subject", subject);
			// === 답변글쓰기가 추가된 경우 끝               === //
			
			mav.setViewName("board/write.board");
			//  /WEB-INF/views/tiles1/board/add.jsp 파일을 생성한다.
		
		    return mav;
		}
		
		
		// === #54. 게시판 글쓰기 완료 요청 === //
		@RequestMapping(value="/write_end.bts", method= {RequestMethod.POST})
//		public ModelAndView addEnd(ModelAndView mav, BoardVO boardvo) {    <== After Advice 를 사용하기 전  
		public ModelAndView write_end(Map<String,String> paraMap, ModelAndView mav, BoardVO boardvo, MultipartHttpServletRequest mrequest) { // <== After Advice 를 사용하기 및 파일 첨부하기 	
		/*
		    form 태그의 name 명과  BoardVO 의 필드명이 같다라면 
		    request.getParameter("form 태그의 name명"); 을 사용하지 않더라도
		        자동적으로 BoardVO boardvo 에 set 되어진다.
		*/
			
			// === #153. !!! 첨부파일이 있는 경우 작업 시작 !!! ===
			MultipartFile attach = boardvo.getAttach();
			
			if( !attach.isEmpty() ) {
				// attach(첨부파일)가 비어 있지 않으면(즉, 첨부파일이 있는 경우라면)
				
				/*
				   1. 사용자가 보낸 첨부파일을 WAS(톰캣)의 특정 폴더에 저장해주어야 한다. 
				   >>> 파일이 업로드 되어질 특정 경로(폴더)지정해주기
				              우리는 WAS의 webapp/resources/files 라는 폴더로 지정해준다.
				              조심할 것은  Package Explorer 에서  files 라는 폴더를 만드는 것이 아니다.       
				*/
				// WAS 의 webapp 의 절대경로를 알아와야 한다.
				HttpSession session = mrequest.getSession();
				String root = session.getServletContext().getRealPath("/");

				String path = root+"resources"+File.separator+"files";
				
				String newFileName = "";
				// WAS(톰캣)의 디스크에 저장될 파일명 
				
				byte[] bytes = null;
				// 첨부파일의 내용물을 담는 것 
				
				long file_size = 0;
				// 첨부파일의 크기 
				
				try {
					bytes = attach.getBytes();
					// 첨부파일의 내용물을 읽어오는 것
					
					String originalFilename = attach.getOriginalFilename();
				 // attach.getOriginalFilename() 이 첨부파일명의 파일명(예: 강아지.png) 이다.
				//	System.out.println("~~~~ 확인용 originalFilename => " + originalFilename);
					// ~~~~ 확인용 originalFilename => LG_싸이킹청소기_사용설명서.pdf
					
					newFileName = fileManager.doFileUpload(bytes, originalFilename, path);
					// 첨부되어진 파일을 업로드 하도록 하는 것이다. 
					
				//	System.out.println(">>> 확인용 newFileName => " + newFileName);
					// >>> 확인용 newFileName => 20220429123036877439302653900.pdf
				
			/*
			   3. BoardVO boardvo 에 fileName 값과 orgFilename 값과 filesize 값을 넣어주기 
			*/
					boardvo.setFilename(newFileName);
					// WAS(톰캣)에 저장될 파일명(2022042912181535243254235235234.png)
					
					boardvo.setOrg_filename(originalFilename);
					// 게시판 페이지에서 첨부된 파일(강아지.png)을 보여줄 때 사용.
					// 또한 사용자가 파일을 다운로드 할때 사용되어지는 파일명으로 사용.
					
					file_size = attach.getSize(); // 첨부파일의 크기(단위는 byte임)
					boardvo.setFile_size(String.valueOf(file_size));
					
				} catch (Exception e) {
					e.printStackTrace();
				}
				
			}
			// === !!! 첨부파일이 있는 경우 작업 끝 !!! ===
			
		
		//	int n = service.add(boardvo);  // <== 파일첨부가 없는 글쓰기 
			
		//  === #156. 파일첨부가 있는 글쓰기 또는 파일첨부가 없는 글쓰기로 나뉘어서 service 호출하기 === // 
		//  먼저 위의  int n = service.add(boardvo); 부분을 주석처리 하고서 아래와 같이 한다.	
			
			int n = 0;
			
			if( attach.isEmpty() ) {
				// 파일첨부가 없는 경우라면 
				n = service.add(boardvo);
			}
			else {
				// 파일첨부가 있는 경우라면 
				n = service.add_withFile(boardvo);
			}
			
			if(n==1) {
				mav.setViewName("redirect:/board/list.bts");
				//  /list.action 페이지로 redirect(페이지이동)해라는 말이다.
			}
			else {
				mav.setViewName("board/error/add_error.tiles1");
				//  /WEB-INF/views/tiles1/board/error/add_error.jsp 파일을 생성한다.
			}
			
			
		
			return mav;
		}
	
	// == 게시판 글쓰기 끝 ==
	
	// == 게시판 글 보기 == //
	// === #62. 글1개를 보여주는 페이지 요청 === //
	@RequestMapping(value="/board/view.bts")
	public ModelAndView view(ModelAndView mav, HttpServletRequest request) {
		
		getCurrentURL(request); // 로그아웃을 했을 때 현재 보이던 그 페이지로 그대로 돌아가기  위한 메소드 호출 
		
		// 조회하고자 하는 글번호 받아오기 
	 	String pk_seq = request.getParameter("pk_seq");
	 	
	 	// 글목록에서 검색되어진 글내용일 경우 이전글제목, 다음글제목은 검색되어진 결과물내의 이전글과 다음글이 나오도록 하기 위한 것이다. 
	 	String searchType = request.getParameter("searchType");
	 	String searchWord = request.getParameter("searchWord");
	 	
	 	if(searchType == null) {
	 		searchType = "";
	 	}
	 	
	 	if(searchWord == null) {
	 		searchWord = "";
	 	}
	 	
	 	
	    // === #125. 페이징 처리되어진 후 특정 글제목을 클릭하여 상세내용을 본 이후
	 	//           사용자가 목록보기 버튼을 클릭했을때 돌아갈 페이지를 알려주기 위해
	 	//           현재 페이지 주소를 뷰단으로 넘겨준다.
	 	String gobackURL = request.getParameter("gobackURL");  
	// 	System.out.println("~~~ 확인용 gobackURL : " + gobackURL);
	 	// ~~~ 확인용 gobackURL : /list.action
	 	// ~~~ 확인용 gobackURL : /list.action?searchType= searchWord= currentShowPageNo=2 
	 	// ~~~ 확인용 gobackURL : /list.action?searchType=subject searchWord=j
	 	// ~~~ 확인용 gobackURL : /list.action?searchType=subject searchWord=j currentShowPageNo=2 
	 	
	 	if( gobackURL != null && gobackURL.contains(" ") ) {
	 		gobackURL = gobackURL.replaceAll(" ", "&");
	 	}
     //	System.out.println("~~~ 확인용 gobackURL : " + gobackURL);
		// ~~~ 확인용 gobackURL : /list.action
		// ~~~ 확인용 gobackURL : /list.action?searchType=&searchWord=&currentShowPageNo=2 
		// ~~~ 확인용 gobackURL : /list.action?searchType=subject&searchWord=j
		// ~~~ 확인용 gobackURL : /list.action?searchType=subject&searchWord=j&currentShowPageNo=2 
	 /*	
	 	System.out.println("~~~~ view 의 searchType : " + searchType);
	    System.out.println("~~~~ view 의 searchWord : " + searchWord);
	    System.out.println("~~~~ view 의 gobackURL : " + gobackURL);
	 */	
	 	mav.addObject("gobackURL", gobackURL);
	 	
	 	// === 125 작업의 끝 === //
	 	///////////////////////////////////////////////////////////////////////
	 	
	 	
	 	try {
		 	Integer.parseInt(pk_seq);
		 	
		 	Map<String, String> paraMap = new HashMap<>();
		 	paraMap.put("pk_seq", pk_seq);
		 	
		 	paraMap.put("searchType", searchType);
		 	paraMap.put("searchWord", searchWord);
		 	
		 	mav.addObject("paraMap", paraMap); // view.jsp 에서 이전글제목 및 다음글제목 클릭시 사용하기 위해서 임.
			
		 	HttpSession session = request.getSession();
		 	EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
		 	
		 	int login_userid1 = 0;
		 	if(loginuser != null) {
		 	   login_userid1 = loginuser.getPk_emp_no();
		 	   // login_userid 는 로그인 되어진 사용자의 userid 이다.
		 	}

		 	String login_userid = Integer.toString(login_userid1);
		 	
		 	paraMap.put("login_userid", login_userid);
		 	
		    // === #68. !!! 중요 !!! 
	        //     글1개를 보여주는 페이지 요청은 select 와 함께 
			//     DML문(지금은 글조회수 증가인 update문)이 포함되어져 있다.
			//     이럴경우 웹브라우저에서 페이지 새로고침(F5)을 했을때 DML문이 실행되어
			//     매번 글조회수 증가가 발생한다.
			//     그래서 우리는 웹브라우저에서 페이지 새로고침(F5)을 했을때는
			//     단순히 select만 해주고 DML문(지금은 글조회수 증가인 update문)은 
			//     실행하지 않도록 해주어야 한다. !!! === //
		 	
		    // 위의 글목록보기 #69. 에서 session.setAttribute("readCountPermission", "yes"); 해두었다. 
		 	BoardVO boardvo = null;
		 	if( "yes".equals(session.getAttribute("readCountPermission")) ) {
		 		// 글목록보기를 클릭한 다음에 특정글을 조회해온 경우이다.
		 	 
		 		boardvo = service.getView(paraMap);
			 	// 글조회수 증가와 함께 글1개를 조회를 해주는 것 
		 		
		 		session.removeAttribute("readCountPermission");
		 		// 중요함!! session 에 저장된 readCountPermission 을 삭제한다.
		 	}
		 	else {
		 		// 웹브라우저에서 새로고침(F5)을 클릭한 경우이다. 
		 		
		 		boardvo = service.getViewWithNoAddCount(paraMap);
			 	// 글조회수 증가는 없고 단순히 글1개 조회만을 해주는 것이다.  
		 	}
		 	
		 	mav.addObject("boardvo", boardvo);
	 	} catch(NumberFormatException e) {
	 		
	 	}
	 	
	 	mav.setViewName("/board/view.board");
	 	
		return mav; 
	}
	
	// === #108. 검색어 입력시 자동글 완성하기 3 === //
	@ResponseBody
	@RequestMapping(value="/wordSearchShow.bts", method= {RequestMethod.GET}, produces="text/plain;charset=UTF-8")
	public String wordSearchShow(HttpServletRequest request) {
		
		String searchType = request.getParameter("searchType");
		String searchWord = request.getParameter("searchWord");
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("searchType", searchType);
		paraMap.put("searchWord", searchWord);
		
		List<String> wordList = service.wordSearchShow(paraMap);
		
		JSONArray jsonArr = new JSONArray(); // []
		
		if(wordList != null) {
			for(String word : wordList) {
				JSONObject jsonObj = new JSONObject();
				jsonObj.put("word", word);
				
				jsonArr.put(jsonObj);
			}// end of for-----------------
		}
		
		return jsonArr.toString();
	}
	
	// == 게시판 글보기 끝  == //
	
	
	
	
	// --- 게시판 끝 --- -------------------
	
	// --- 자료 게시판 시작 ---  -----------------
	@RequestMapping(value = "/fileboard/list.bts")      // URL, 절대경로 contextPath 인 board 뒤의 것들을 가져온다. (확장자.java 와 확장자.xml 은 그 앞에 contextPath 가 빠져있는 것이다.)
    public String fileboard_list(HttpServletRequest request) {

		      
	       return "/fileboard/list.board";
	}
	// --- 자료 게시판 끝 --- -------------------
	
	
	// --- 공지 게시판 시작 ---  -----------------
	@RequestMapping(value = "/notice/list.bts")      // URL, 절대경로 contextPath 인 board 뒤의 것들을 가져온다. (확장자.java 와 확장자.xml 은 그 앞에 contextPath 가 빠져있는 것이다.)
    public String notice_test(HttpServletRequest request) {

		      
	       return "/notice/list.board";
	}
	// --- 공지 게시판 끝 ---  -----------------
	
	
	
	// === 로그인 또는 로그아웃을 했을 때 현재 보이던 그 페이지로 그대로 돌아가기  위한 메소드 생성 === //
		public void getCurrentURL(HttpServletRequest request) {
			HttpSession session = request.getSession();
			session.setAttribute("goBackURL", MyUtil.getCurrentURL(request));
		}
	
	
}
