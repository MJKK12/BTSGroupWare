<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- === #24. tiles 를 사용하는 레이아웃1 페이지 만들기 === --%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>

<%
	String ctxPath = request.getContextPath();
%>    
    
<!DOCTYPE html>
<html>
<head>
<title>게시판</title>
  <!-- Required meta tags -->
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"> 
  
  <!-- Bootstrap CSS -->
  <link rel="stylesheet" type="text/css" href="<%= ctxPath%>/resources/bootstrap-4.6.0-dist/css/bootstrap.min.css" > 

  <!-- Font Awesome 5 Icons -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
  
  <!-- 직접 만든 CSS 1 -->
  <link rel="stylesheet" type="text/css" href="<%=ctxPath %>/resources/css/style1.css" />
  
  <!-- Optional JavaScript -->
  <script type="text/javascript" src="<%= ctxPath%>/resources/js/jquery-3.6.0.min.js"></script>
  <script type="text/javascript" src="<%= ctxPath%>/resources/bootstrap-4.6.0-dist/js/bootstrap.bundle.min.js" ></script> 
  <script type="text/javascript" src="<%= ctxPath%>/resources/smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script> 
  
  <%--  ===== 스피너 및 datepicker 를 사용하기 위해  jquery-ui 사용하기 ===== --%>
  <link rel="stylesheet" type="text/css" href="<%= ctxPath%>/resources/jquery-ui-1.13.1.custom/jquery-ui.css" />
  <script type="text/javascript" src="<%= ctxPath%>/resources/jquery-ui-1.13.1.custom/jquery-ui.js"></script>

  <%-- *** ajax로 파일을 업로드할때 가장 널리 사용하는 방법 ==> ajaxForm *** --%>
  <script type="text/javascript" src="<%= ctxPath%>/resources/js/jquery.form.min.js"></script>

  <!-- 구글 폰트를 쓰기 위한 링크 -->
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Nanum+Myeongjo&family=Noto+Sans+KR&display=swap" rel="stylesheet">


<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>SB Admin 2 - Login</title>

    <!-- Custom fonts for this template-->
    <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="css/sb-admin-2.min.css" rel="stylesheet">

	<style type="text/css">
	
		body {
			margin-top: 100px;
		}
	
		div#image > img {
			max-width: 475px;
			min-height: 538px;
			border-radius: 0.25rem;
		}
	
	</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		/* var 변수명 = '1234';
		    선택자.attr()*/
		if(localStorage.getItem("keep") != null){
			var gab = localStorage.getItem("keep");
			$('#loginUserid').attr('value', gab);
			$('#keep').attr('checked', "checked");
		}
		
		$("button#btnLOGIN").click(function(){
			func_Login();
		});
		
		$("input#pwd").keydown(function(event){
			
			if(event.keyCode == 13) { // 엔터를 했을 경우
				func_Login();	
			}
		});
		
		
	}); // end of $(document).ready(function(){})-----------

	// Function Declaration
	function func_Login(){
		
		const userid = $("input#userid").val().trim(); 
        const pwd = $("input#pwd").val().trim(); 
      
        if(userid.trim()=="") {
           alert("아이디를 입력하세요!!");
          $("input#userid").val(""); 
          $("input#userid").focus();
          return; // 종료 
        }
      
        if(pwd.trim()=="") {
          alert("비밀번호를 입력하세요!!");
          $("input#pwd").val(""); 
          $("input#pwd").focus();
          return; // 종료 
        }
        
        
        if( $("input:checkbox[id='keep']").prop("checked") ) {
        	localStorage.setItem('keep',$("input#loginUserid").val());
        }
        else {
        	localStorage.removeItem('keep');
        }
        
        const frm = document.loginFrm
        frm.action ="<%= ctxPath%>/loginEnd.bts";
		frm.method = "post";
		frm.submit();
		
	} // end of function func_Login()-------------
	
</script>

</head>

<body class="bg-gradient-primary">

    <div class="container">

        <!-- Outer Row -->
        <div class="row justify-content-center">

            <div class="col-xl-10 col-lg-12 col-md-9">

                <div class="card o-hidden border-0 shadow-lg my-5">
                    <div class="card-body p-0">
                        <!-- Nested Row within Card Body -->
                        <div class="row">
                            <div class="col-lg-6 d-none d-lg-block bg-login-image" id="image"><img src="<%= ctxPath%>/resources/images/login_main.jpg" title="" /></div>
                            <div class="col-lg-6">
                                <div class="p-5">
                                    <div class="text-center">
                                        <h1 class="h4 text-gray-900 mb-4">BTSGroupware</h1>
                                    </div>
                                    <form class="loginFrm">
                                        <div class="form-group">
                                            <input type="text" class="form-control form-control-user"
                                                name="userid" id="userid" value="" aria-describedby="emailHelp"
                                                placeholder="아이디">
                                        </div>
                                        <div class="form-group">
                                            <input type="password" class="form-control form-control-user"
                                                name="pwd" id="pwd" value="" placeholder="비밀번호">
                                        </div>
                                        <div class="form-group">
                                            <div class="custom-control custom-checkbox small">
                                                <input type="checkbox" id="keep" class="custom-control-input input_keep" value="off" id="customCheck">
                                                <label class="custom-control-label" for="customCheck">아이디 기억하기</label>
                                            </div>
                                        </div>
                                        <button type="button" class="btn btn-primary btn-user btn-block" id="btnLOGIN">
                                            	로그인
                                        </button>
                                        <hr>
                                        <div id="center" style="text-align: center;">
                                        <span>오늘도 좋은 하루 되세요!</span>
                                        </div>
                                        <!-- 
                                        <a href="index.html" class="btn btn-google btn-user btn-block">
                                            <i class="fab fa-google fa-fw"></i> Login with Google
                                        </a>
                                        <a href="index.html" class="btn btn-facebook btn-user btn-block">
                                             <i class="fab fa-facebook-f fa-fw"></i> Login with Facebook
                                        </a>
                                        -->
                                    </form>
                                    <hr>
                                    <div class="text-center">
                                        <a href="forgot-password.html">비밀번호 찾기</a>
                                    </div>
                                    <div class="text-center">
                                        	문의 : 인사과(정환모 / 8887)
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

        </div>

    </div>

    <!-- Core plugin JavaScript-->
    <script src="vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="js/sb-admin-2.min.js"></script>

</body>

</html>