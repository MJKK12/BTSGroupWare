<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<%
   String ctxPath = request.getContextPath();
  //       /board 
%>

<title>부서상세정보</title>

<style type="text/css">

	#tbl_depName { 
		border-collapse: separate;
		border-spacing: 0 12px;
	}

/* ----------------------------------------------------  */


.highcharts-figure,
.highcharts-data-table table {
    min-width: 360px;
    max-width: 800px;
    margin: 1em auto;
}

.highcharts-data-table table {
    font-family: Verdana, sans-serif;
    border-collapse: collapse;
    border: 1px solid #ebebeb;
    margin: 10px auto;
    text-align: center;
    width: 100%;
    max-width: 500px;
}

.highcharts-data-table caption {
    padding: 1em 0;
    font-size: 1.2em;
    color: #555;
}

.highcharts-data-table th {
    font-weight: 600;
    padding: 0.5em;
}

.highcharts-data-table td,
.highcharts-data-table th,
.highcharts-data-table caption {
    padding: 0.5em;
}

.highcharts-data-table thead tr,
.highcharts-data-table tr:nth-child(even) {
    background: #f8f8f8;
}

.highcharts-data-table tr:hover {
    background: #f1f7ff;
}

#container h4 {
    text-transform: none;
    font-size: 14px;
    font-weight: normal;
}

#container p {
    font-size: 13px;
    line-height: 16px;
}

@media screen and (max-width: 600px) {
    #container h4 {
        font-size: 2.3vw;
        line-height: 3vw;
    }

    #container p {
        font-size: 2.3vw;
        line-height: 3vw;
    }
}



	


</style>




<h1>조직도</h1>
<br>

<ul class="nav nav-tabs">
  <li class="nav-item">
    <a class="nav-link active" data-toggle="tab" href="#depName">부서정보</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" data-toggle="tab" href="#depInfo">부서원 목록</a>
  </li>
</ul>
<div class="tab-content">
  <div class="tab-pane fade show active" id="depName">
    
<figure class="highcharts-figure">
    <div id="container" style="margin-top:15%; /* 글꼴  */-webkit-text-stroke-width: thin;"></div>
    
</figure>

  </div>
  
  <!-- 부서원 목록  -->
  <div class="tab-pane fade" id="depInfo">
	  <table style="float:left; text-align:center;">
			<tr>
				<td><button class="btn btn-default" id="y_team" style="width:150px; border: solid darkgray 2px;">영업팀</button></td>
			</tr>
			<c:forEach var="emp" items="${requestScope.empList}" varStatus="i">
			<c:if test="${emp.ko_depname  eq '영업'}">
			<tr>
			<td>
				<div id="y_teamwon">
					<input type="hidden" id="pk_emp_no_${i.count}" name="pk_emp_no_${i.count}" value="${emp.pk_emp_no}" readonly />
					<button class="btn btn-default" onclick="teamwonInfo(${i.count})" >${emp.emp_name}&nbsp;[${emp.ko_rankname}]</button>
				</div>
			</td>
			</tr>
			</c:if>
	   		</c:forEach>
			<tr>
				<td><button class="btn btn-default" id="m_team" style="width:150px; border: solid darkgray 2px;">마케팅팀</button></td>
			</tr>
			<c:forEach var="emp" items="${requestScope.empList}" varStatus="i">
			<c:if test="${emp.ko_depname  eq '마케팅'}">
			<tr>
			<td>
				<div id="m_teamwon">
					<input type="hidden" id="pk_emp_no_${i.count}" name="pk_emp_no_${i.count}" value="${emp.pk_emp_no}" readonly />
					<button class="btn btn-default" onclick="teamwonInfo(${i.count})" >${emp.emp_name}&nbsp;[${emp.ko_rankname}]</button>
				</div>
			</td>
			</tr>
			</c:if>
	   		</c:forEach>
			<tr>
				<td><button class="btn btn-default" id="g_team" style="width:150px; border: solid darkgray 2px;">기획팀</button></td>
			</tr>
			<c:forEach var="emp" items="${requestScope.empList}" varStatus="i">
			<c:if test="${emp.ko_depname  eq '기획'}">
			<tr>
			<td>
				<div id="g_teamwon">
					<input type="hidden" id="pk_emp_no_${i.count}" name="pk_emp_no_${i.count}" value="${emp.pk_emp_no}" readonly />
					<button class="btn btn-default" onclick="teamwonInfo(${i.count})" >${emp.emp_name}&nbsp;[${emp.ko_rankname}]</button>
				</div>
			</td>
			</tr>
			</c:if>
	   		</c:forEach>
			<tr>
				<td><button class="btn btn-default" id="c_team" style="width:150px; border: solid darkgray 2px;">총무팀</button></td>
			</tr>
			<c:forEach var="emp" items="${requestScope.empList}" varStatus="i">
			<c:if test="${emp.ko_depname  eq '총무'}">
			<tr>
			<td>
				<div id="c_teamwon">
					<input type="hidden" id="pk_emp_no_${i.count}" name="pk_emp_no_${i.count}" value="${emp.pk_emp_no}" readonly />
					<button class="btn btn-default" onclick="teamwonInfo(${i.count})" >${emp.emp_name}&nbsp;[${emp.ko_rankname}]</button>
				</div>
			</td>
			</tr>
			</c:if>
	   		</c:forEach>
			<tr>
				<td><button class="btn btn-default" id="i_team" style="width:150px; border: solid darkgray 2px;">인사팀</button></td>
			</tr>
			<c:forEach var="emp" items="${requestScope.empList}" varStatus="i">
			<c:if test="${emp.ko_depname  eq '인사'}">
			<tr>
			<td>
				<div id="i_teamwon">
					<input type="hidden" id="pk_emp_no_${i.count}" name="pk_emp_no_${i.count}" value="${emp.pk_emp_no}" readonly />
					<button class="btn btn-default" onclick="teamwonInfo(${i.count})" >${emp.emp_name}&nbsp;[${emp.ko_rankname}]</button>
				</div>
			</td>
			</tr>
			</c:if>
	   		</c:forEach>
			<tr>
				<td><button class="btn btn-default" id="h_team" style="width:150px; border: solid darkgray 2px;">회계팀</button></td>
			</tr>
			<c:forEach var="emp" items="${requestScope.empList}" varStatus="i">
			<c:if test="${emp.ko_depname  eq '회계'}">
			<tr>
			<td>
				<div id="h_teamwon">
					<input type="hidden" id="pk_emp_no_${i.count}" name="pk_emp_no_${i.count}" value="${emp.pk_emp_no}" readonly />
					<button class="btn btn-default" onclick="teamwonInfo(${i.count})" >${emp.emp_name}&nbsp;[${emp.ko_rankname}]</button>
				</div>
			</td>
			</tr>
			</c:if>
	   		</c:forEach>
			
  	</table>
  	
  	
	 <div id="telAdd_main_tbl" style="text-align:center;">
		<form name="updateFrm">
		<table>
			<tr>
				<td><h2>개인정보</h2>
					<input type="hidden" id="user" name="user" value="${sessionScope.loginuser.pk_emp_no}">
					<input type="hidden" id="select_user_no" name="select_user_no" value="" readonly />
				</td>
			</tr>
			<tr>
				<td><strong>사진</strong></td>
				<td><img src="<%=ctxPath %>/resources/images/addBook_perInfo_sample.jpg" class="img-rounded"><!-- <button class="btn btn-default" id="telAdd_mini_btn">삭제</button> --></td>
			</tr>
			<tr>
				<td><strong>이름*</strong></td>
				<td style="padding-top:25px;">
					<input type="text" class="form-control requiredInfo" id="name" name="name" placeholder="이름" maxlength="4">
				<span class="error">이름을 입력해주세요.</span> 
				<span id="idcheckResult"></span>
				<br>
				</td>
				
			</tr>
			<c:choose>
		 	<c:when test="${sessionScope.loginuser.pk_emp_no eq 80000001}">
			<tr>
				<td style="padding-bottom:25px;"><strong>부서*</strong></td>
				<td>
					<select id="department" name="department" class="form-control requiredInfo">
					  <option value="100">영업</option>
					  <option value="200">마케팅</option>
					  <option value="300">기획</option>
					  <option value="400">총무</option>
					  <option value="500">인사</option>
					  <option value="600">회계</option>
					</select>
				<br>
				</td>
			</tr>
			<tr>
				<td style="padding-bottom:25px;"><strong>직급*</strong></td>
				<td>
					<select id="rank" name="rank" class="form-control requiredInfo">
					  <option value="10">사원</option>
					  <option value="20">주임</option>
					  <option value="30">대리</option>
					  <option value="40">과장</option>
					  <option value="50">차장</option>
					  <option value="60">부장</option>
					  <option value="70">전무</option>
					  <option value="80">사장</option>
					</select>
				</td>
			</tr>
			<tr>
				<td style="padding-bottom:25px;"><strong>이메일*</strong></td>
				<td>
					<p>
					<input class="form-control requiredInfo" id="email" name="email" style="width:260px; margin-top:2%; display:inline;" type="text" maxlength="20">
					<!--  
					<input class="form-control requiredInfo" id="email2" name="email2" style="width:135px; margin-top:2%; display:inline;" type="text" maxlength="12" placeholder="직접입력">&nbsp;
					<select class="form-control" name="select_email" style="width:137px; display:inline;" onChange="selectEmail(this)">
						<option value="gmail.com">gmail.com</option>
						<option value="naver.com">naver.com</option>
						<option value="nate.com">nate.com</option>
						<option value="hanmail.net">hanmail.net</option>
						<option value="1" selected>직접입력</option>
					</select>
					-->
					<input type="button" id="isExistIdCheck" class="duplicateCheck form-control" style="display:inline; width:174px;" onclick="isExistEmailCheck();" value="이메일중복확인" />
					<br>
					<span class="error">올바른 이메일 양식이 아닙니다.</span>
					<span id="emailCheckResult"></span>
					</p>
				</td>
			</tr>
			<tr>
				<td style="padding-bottom:25px;"><strong>휴대폰*</strong></td>
				<td>
					<select class="form-control requiredInfo" id="hp1" name="hp1" style="width:135px; display:inline;" >
						<option value="010">010</option>
					</select>&nbsp;-&nbsp;
					<input class="form-control requiredInfo" id="hp2" name="hp2" style="width:135px; display:inline;" type="text" size="5" maxlength="4" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">&nbsp;-&nbsp; 
					<input class="form-control requiredInfo" id="hp3" name="hp3" style="width:135px; display:inline;" type="text" size="5" maxlength="4" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">
					<span class="error">올바른 휴대전화 번호가 아닙니다.</span>
				<br>
				</td>
			</tr>
			</c:when>
			<c:otherwise>
			<tr>
				<td style="padding-bottom:25px;"><strong>부서</strong></td>
				<td><input type="text" class="form-control requiredInfo" id="department" name="department" placeholder="부서"  ><br></td>
			</tr>
			<tr>
				<td style="padding-bottom:25px;"><strong>직급</strong></td>
				<td><input type="text" class="form-control" id="rank" name="rank" placeholder="직급" ><br></td>
			</tr>
			<tr>
				<td style="padding-bottom:25px;"><strong>이메일</strong></td>
				<td><input type="text" class="form-control" id="email" name="email" placeholder="이메일" ><br></td>
			</tr>
			<tr>
				<td style="padding-bottom:25px;"><strong>휴대폰</strong></td>
				<td><input type="text" class="form-control" id="phone" name="phone" placeholder="휴대폰" ><br></td>
				<span class="error">올바른 휴대전화 번호가 아닙니다.</span>
			</tr>
		 	</c:otherwise>
		 	</c:choose>
			<tr>
				<td style="padding-bottom:25px;"><strong>주소</strong></td>
				<td><input type="text" class="form-control" id="address" name="address" placeholder="주소" style="" ><br></td>
			</tr>
			<tr>
				<td><strong>상세주소</strong></td>
				<td><input type="text" class="form-control" id="detailaddress" name="detailaddress" placeholder="상세주소" style="" ></td>
			</tr>
			<c:choose>
		 	<c:when test="${sessionScope.loginuser.pk_emp_no eq 80000001}">
		 	</c:when>
		 	<c:otherwise>
		 	</c:otherwise>
		 	</c:choose>
			<tr>
				<td></td>
				<td colspan="10" style="text-align:center; padding-top: 18%; ">
					<input type="button" class="btn btn-info" id="btn_update" style="border: solid lightgray 2px;" onclick="update()" value="저장">
				</td>
			</tr>
		 </table>
		 </form>
	</div>
	</div>
</div>




<script type="text/javascript">

	$( document ).ready( function() {
	
	  $( "div#y_teamwon" ).slideToggle().hide();
	  $( "button#y_team" ).click( function() {
	      $( "div#y_teamwon" ).slideToggle();
	    });
		  
	  $( "div#m_teamwon" ).slideToggle().hide();
	  $( "button#m_team" ).click( function() {
	    $( "div#m_teamwon" ).slideToggle();
	  });
	  
	  $( "div#g_teamwon" ).slideToggle().hide();
	  $( "button#g_team" ).click( function() {
	    $( "div#g_teamwon" ).slideToggle();
	  });
	  
	  $( "div#c_teamwon" ).slideToggle().hide();
	  $( "button#c_team" ).click( function() {
	    $( "div#c_teamwon" ).slideToggle();
	  });
	  
	  $( "div#i_teamwon" ).slideToggle().hide();
	  $( "button#i_team" ).click( function() {
	    $( "div#i_teamwon" ).slideToggle();
	  });
	  
	  $( "div#h_teamwon" ).slideToggle().hide();
	  $( "button#h_team" ).click( function() {
	    $( "div#h_teamwon" ).slideToggle();
	  });
/////////////////////////////////////////////////////	  
	  
	  if ( $("input#user").val() != 80000001 ) {
		  $('#name').attr("disabled", "disabled");
		  $('#department').attr("disabled", "disabled");
		  $('#rank').attr("disabled", "disabled");
		  $('#email').attr("disabled", "disabled");
		  $('#phone').attr("disabled", "disabled");
		  $('#address').attr("disabled", "disabled");
		  $('#detailaddress').attr("disabled", "disabled");
	  }
	
	  
	}); // end of $( document ).ready( function()

			
	function teamwonInfo(i)	{
		$.ajax({
			url:"<%= ctxPath%>/addBook/addBook_depInfo_select_ajax.bts",
			data:{"pk_emp_no" : $("input#pk_emp_no_"+i).val()},
			type: "post",
			dataType: 'json',
			success : function(json) {
				
				var a; // 부서 select
				var b; // 직급 select
				
				switch (json.department) {
					case "영업": a=100; break;
					case "마케팅": a=200; break;
					case "기획": a=300; break;
					case "총무": a=400; break;
					case "인사": a=500; break;
					case "회계": a=600; break;
					case "--": a=700; break;
				}
				
				switch (json.rank) {
					case "사원": b=10; break;
					case "주임": b=20; break;
					case "대리": b=30; break;
					case "과장": b=40; break;
					case "차장": b=50; break;
					case "부장": b=60; break;
					case "전무": b=70; break;
					case "사장": b=80; break;
					case "--": b=90; break;
				}
				
				$("input#select_user_no").val(json.pk_emp_no)
				$("input#name").val(json.name)
				$("input#rank").val(json.rank)
				$("input#department").val(json.department)
				$("select#department").val(a).prop("selected",true);
				$("select#rank").val(b).prop("selected",true);
				$("input#email").val(json.email)
				$("input#phone").val(json.phone)
				$("input#hp2").val(json.hp2)
				$("input#email1").val(json.email1)
				$("input#email2").val(json.email2)
				$("input#hp3").val(json.hp3)
				$("input#address").val(json.address)
				$("input#detailaddress").val(json.detailaddress)
			},
			error: function(request){
				
			}
		});
	}	
	
<%-- 
	/* 이메일 선택or직접입력 */
	function selectEmail(ele){ 
		var $ele = $(ele); 
		var $email2 = $('input[name=email2]');
		
		// '1'인 경우 직접입력 
		if($ele.val() == "1"){ 
			$email2.attr('readonly', false); 
			$email2.val(''); 
		} else { 
			$email2.attr('readonly', true); 
			$email2.val($ele.val()); 
		} 
	}
	/* 이메일 선택or직접입력 */
--%>	
///////////////////////////////////////////////////////////////
	/* -------------- 유효성 검사 시작 --------------  */

	let b_flagEmailDuplicateClick = false;
	// 가입하기 버튼 클릭시 "이메일중복확인" 을 클릭했는지 클릭안했는지를 알아보기 위한 용도이다.

	/* 이름 유효성검사 */
	$("span.error").hide();	
		$("input#name").focus();
		
		// 아이디가 name 제약 조건 
		$("input#name").blur(() => { 
			const $target = $(event.target);
			
			const name = $target.val().trim();
			if(name == ""){
				// 입력하지 않거나 공백만 입력했을 경우
				$("table#telAdd_main_tbl :input").prop("disabled", true);
				$target.prop("disabled", false);
			//	$target.next().show();
			// 	또는
				$target.parent().find(".error").show();
			
				$target.focus();
				
				
			} else {
				// 공백이 아닌 글자를 입력했을 경우
				$("table#telAdd_main_tbl :input").prop("disabled", false);
				//	$target.next().hide();
				// 	또는
				$target.parent().find(".error").hide();
			}
		}); // end of $("input#emp_name").blur(() => {})-------------------------------------------
		
		
		// 아이디가 email 제약 조건 
		$("input#email").blur(() => {
			const $target = $(event.target);
			
	        const regExp = new RegExp(/^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i); 
	        // 이메일 정규표현식 객체 생성
		    
	         const bool = regExp.test($target.val());  
	        
			if(!bool){ // !bool == false 이메일이 정규표현식에 위배된 경우
				// 이메일이 정규표현식에 위배된 경우 
				$("table#telAdd_main_tbl :input").prop("disabled", true);
				$target.prop("disabled", false);
				
			//	$target.next().show();
			// 	또는
				$target.parent().find(".error").show();
			
				$target.focus();
				
			} else {
				// bool == true 이메일이 정규표현식에 맞는 경우
				$("table#telAdd_main_tbl :input").prop("disabled", false);
				
				//	$target.next().hide();
				// 	또는
				$target.parent().find(".error").hide();
			}
		}); // end of $("input#uq_email").blur(() => {})---------------------------
		
		
	// 아이디가 hp2인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.
		
		$("input#hp2").blur(() => {
			const $target = $(event.target);
			
	        const regExp = new RegExp(/^[1-9][0-9]{3}$/g); 
	        // 숫자 4자리만 들어오도록 검사해주는 정규표현식 객체 생성(첫글자는 숫자 1~9까지만 가능함)
		    
	         const bool = regExp.test($target.val());  
	        
			if(!bool){ // !bool == false 국번이 정규표현식에 위배된 경우
				$("table#telAdd_main_tbl :input").prop("disabled", true);
				  $target.prop("disabled", false);
			
			//	$target.next().show();
			// 	또는
				$target.parent().find(".error").show();
				
				$target.focus();
			} else {
				// bool == true 국번이 정규표현식에 맞는 경우
				$("table#telAdd_main_tbl :input").prop("disabled", false);
				
				//	$target.next().hide();
				// 	또는
				$target.parent().find(".error").hide();
			}
		});  // end of $("input#hp2").blur(() => {})----------------------------------
		
		// 아이디가 hp3인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.
		
		$("input#hp3").blur(() => {
			const $target = $(event.target);
			
	        const regExp = new RegExp(/^[1-9][0-9]{3}$/g); 
	        // 숫자 4자리만 들어오도록 검사해주는 정규표현식 객체 생성(첫글자는 숫자 1~9까지만 가능함)
		    
	         const bool = regExp.test($target.val());  
	        
			if(!bool){ // !bool == false 국번이 정규표현식에 위배된 경우
				$("table#telAdd_main_tbl :input").prop("disabled", true);
				  $target.prop("disabled", false);
			
			//	$target.next().show();
			// 	또는
				$target.parent().find(".error").show();
				
				$target.focus();
			} else {
				// bool == true 국번이 정규표현식에 맞는 경우
				$("table#telAdd_main_tbl :input").prop("disabled", false);
				
				//	$target.next().hide();
				// 	또는
				$target.parent().find(".error").hide();
			}
		});  // end of $("input#hp3").blur(() => {})----------------------------------
		

		// 이메일 중복여부 검사하기
		function isExistEmailCheck(){
			b_flagEmailDuplicateClick = true;
		 	// 가입하기 버튼 클릭시 "아이디중복확인" 을 클릭했는지 클릭안했는지를 알아보기 위한 용도이다.
		 	
		 	// 입력하고자 하는 이메일이 데이터베이스 테이블에 존재하는지 존재하지 않는지 알아와야한다.
		 	/*
	     	    Ajax (Asynchronous JavaScript and XML)란?
	       		==> 이름만 보면 알 수 있듯이 '비동기 방식의 자바스크립트와 XML' 로서
	       	    Asynchronous JavaScript + XML 인 것이다.
	       	    한마디로 말하면, Ajax 란? Client 와 Server 간에 XML 데이터를 JavaScript 를 사용하여 비동기 통신으로 주고 받는 기술이다.
	       	    하지만 요즘에는 데이터 전송을 위한 데이터 포맷방법으로 XML 을 사용하기 보다는 JSON 을 더 많이 사용한다.
	       	    참고로 HTML은 데이터 표현을 위한 포맷방법이다.
	       	    그리고, 비동기식이란 어떤 하나의 웹페이지에서 여러가지 서로 다른 다양한 일처리가 개별적으로 발생한다는 뜻으로서, 
	       	    어떤 하나의 웹페이지에서 서버와 통신하는 그 일처리가 발생하는 동안 일처리가 마무리 되기전에 또 다른 작업을 할 수 있다는 의미이다.
	        */
			// ==== jQuery 를 이용한 Ajax (Asynchronous JavaScript and XML)처리하기 ====
		 		$.ajax({
		 			url:"<%= ctxPath%>/addBook/emailDuplicateCheck.bts",
		 			data:{"email":$("input#email").val()
		 				}, // data 는 MyMVC/member/emailDuplicateCheck.up로 전송해야할 데이터를 말한다.
		 			type: "post" , // type 은 생략하면 "get" 이다.
					dataType: "json",
					success: function(json){
		 			
		 			const regExp = new RegExp(/^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i); 
		 			const bool = regExp.test($("input#email").val());  	
		 			
		 				if(json.isExist) {	// 입력한 $("input#uq_email").val() 값이 이미 사용중이라면
		 					$("span#emailCheckResult").html($("input#email").val()+"은 중복된 ID 이므로 사용 불가합니다.").css("color","red");
		 					$("input#email").val("");
		 				} else if( !bool ) {
		 					
		 				} else {	// 입력한 $("input#uq_email").val() 값이 DB테이블(tbl_member)에 존재하지 않는 경우라면
		 					$("span#emailCheckResult").html($("input#email").val()+"은 사용 가능합니다.").css("color","green");
		 				}
	                   
		 			}, 
		 			error: function(request, status, error){
		 				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		 			}
		 			
		 		}); // end of $.ajax({})
		 	
		} // end of function isExistEmailCheck(){}---------------------------------------
		
	
		// 가입하기		
		function update() {
			
			// *** 필수입력사항에 모두 입력이 되었는지 검사한다. *** //
			let b_FlagRequiredInfo = false;
			
			$("input.requiredInfo").each(function(index, item) {
				const data = $(item).val().trim();
				if(data == ""){
					console.log("item : " + data);
					alert("*표시된 필수입력사항은 모두 입력하셔야 합니다.");
					b_FlagRequiredInfo = true;
					return false; // each문에서 for문에서 break; 와 같은 기능이다.
				}
			});
			
			if(b_FlagRequiredInfo) {
				console.log("b_FlagRequiredInfo : " + b_FlagRequiredInfo);
				return;
			}
			  
			  
			// *** 이메일 중복확인을 클릭했는지 검사한다. *** //
			if(!b_flagEmailDuplicateClick) {
				// "이메일중복확인" 을 클릭했는지 클릭안했는지를 알아보기위한 용도임.
				alert("이메일중복확인 클릭하여 email 중복검사를 하세요!!");
				return; // 종료
			}
			
			const frm = document.updateFrm;
			frm.action = "<%= ctxPath%>/addBook/addBook_depInfo_update.bts"
			frm.method = "POST";
			frm.submit();
			
			
		}// end of 	function goRegister()--------------------------------
		
	
		/* -------------- 유효성 검사 끝 --------------  */			
			
/* 조직도  */

Highcharts.chart('container', {
    chart: {
        height: 800,
        inverted: true
    },

    title: {
        text: 'B.T.S 조직도'
    },

    accessibility: {
        point: {
            descriptionFormatter: function (point) {
                var nodeName = point.toNode.name,
                    nodeId = point.toNode.id,
                    nodeDesc = nodeName === nodeId ? nodeName : nodeName + ', ' + nodeId,
                    parentDesc = point.fromNode.id;
                return point.index + '. ' + nodeDesc + ', reports to ' + parentDesc + '.';
            }
        }
    },

    series: [{
        type: 'organization',
        name: 'Highsoft',
        keys: ['from', 'to'],
        data: [
            ['CEO', 'exe_director'],
            ['exe_director', 'sales_team'],
            ['exe_director', 'marketing_team'],
            ['exe_director', 'planning_team'],
            ['exe_director', 'manager_team'],
            ['exe_director', 'personnel_team'],
            ['exe_director', 'accounting_team'],
           
        ],
        levels: [{
            level: 0,
            color: 'black',
            dataLabels: {
                color: 'white'
            },
            height: 10
        }, {
            level: 1,
            color: 'silver',
            dataLabels: {
                color: 'black'
            },
            height: 10
        }, {
            level: 2,
            color: '#980104'
        }, {
            level: 4,
            color: '#359154'
        }],
        nodes: [{
            id: 'CEO',
            title: '[사장]',
            name: '이순신',
        }, {
            id: 'exe_director',
            title: '[전무]',
            name: '엄정화',
        }, {
            id: 'sales_team',
            title: 'sales_team',
            name: '영업',
            color: '#007ad0',
        }, {
            id: 'marketing_team',
            title: 'marketing_team',
            name: '마케팅',
            color: '#007ad0',
        }, {
            id: 'planning_team',
            title: 'planning_team',
            name: '기획',
            color: '#007ad0',
        }, {
        	id: 'manager_team',
            title: 'manager_team',
            name: '총무',
        }, {
        	id: 'personnel_team',
            title: 'personnel_team',
            name: '인사',
        }, {
        	id: 'accounting_team',
            title: 'accounting_team',
            name: '회계',
        }],
        colorByPoint: false,
        color: '#007ad0',
        dataLabels: {
            color: 'white'
        },
        borderColor: 'white',
        nodeWidth: 90
    }],
    tooltip: {
        outside: true
    },
    exporting: {
        allowHTML: true,
        sourceWidth: 800,
        sourceHeight: 600
    }

});

/* 조직도  */

</script>
