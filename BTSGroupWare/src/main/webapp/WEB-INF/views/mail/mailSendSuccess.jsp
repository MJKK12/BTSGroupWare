<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>

<style>
	a {
	color: gray;
	font-size: 12px;
	}
</style> 
    
<div class="container" style="text-align: center;">

	<div>메일을 성공적으로 보냈습니다.</div>
	<div><img src="<%= ctxPath%>/resources/images/mail/SendMailSuccess.png"></div>
	
	
	<a href="<%= ctxPath%>/mail/mailSendList.bts">보낸메일함으로 이동하기&nbsp;|</a>
	<a href="<%= ctxPath%>/mail/mailWrite.bts">메일쓰기</a>

</div>    


    