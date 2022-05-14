<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
    
<%
    String ctxPath = request.getContextPath();
    //    /bts
%>

<style type="text/css">

	span.subject
	{cursor: pointer;}
	
	a { text-decoration: none !important}

</style>

<script type="text/javascript">

	$(document).ready(function() {
		
		// 검색타입 및 검색어 유지시키기
		if(${searchWord != null}) {
			// 넘어온 paraMap 이 null 이 아닐 때 (값이 존재할 때)
			$("select#searchType").val("${searchType}");
			$("input#searchWord").val("${searchWord}");
		}
		
		if(${searchWord != null}) {
			$("select#searchType").val("subject");
			$("input#searchWord").val("");
		}
		
		// 체크박스 전체선택 및 해제
		$("input#checkAll").click(function() {
			if($(this).prop("checked")) {
				$("input[name='chkBox']").prop("checked",true);
			}
			else {
				$("input[name='chkBox']").prop("checked",false);
			}
			
		});
		
	}); // end of $(document).ready(function(){})----------------------------------
	

	// function declaration 
	// 검색 버튼 클릭시 동작하는 함수
	function gomailSearch() {
		const frm = document.goReceiveListSelectFrm;
		frm.method = "GET";
		frm.action = "<%= ctxPath%>/mail/mailRecyclebinList.bts";
		frm.submit();	
	}// end of function goMailSearch(){}-------------------------

	
	// 글제목 클릭 시 글내용 보여주기 (고유한 글번호인 pk_mail_num 를 넘겨준다.)
	function goRecMailView(pk_mail_num) {
		const searchType = $("select#searchType").val();
		const searchWord = $("input#searchWord").val();
		
		location.href = "<%= ctxPath%>/mail/mailRecyclebinDetail.bts?pk_mail_num="+pk_mail_num+"&searchType="+searchType+"&searchWord="+searchWord;
<%-- 	<a href="<%= ctxPath%>/mail/mailReceiveDetail.bts?searchType=${}&searchWord=${}&pk_mail_num=${}">${mailvo.subject}</a> --%>
	}
	

	// 삭제버튼 클릭 시 휴지통으로 이동하기 (ajax)
	function goMailDelRecyclebin() {
		
		// 체크된 갯수 세기
		var chkCnt = $("input[name='chkBox']:checked").length;
		
		// 배열에 체크된 행의 pk_mail_num 넣기
		var arrChk = new Array();
		
		$("input[name='chkBox']:checked").each(function(){
			
			var pk_mail_num = $(this).attr('id');
			arrChk.push(pk_mail_num);
		//	console.log("arrChk 확인용 : " + arrChk);
			
		});
		
		if(chkCnt == 0) {
			alert("선택된 메일이 없습니다.");
		}
		else {
			
			$.ajax({				
		 	    url:"<%= ctxPath%>/mail/mailRecyclebinClear.bts", 
				type:"GET",
				data: {"pk_mail_num":JSON.stringify(arrChk),
							   "cnt":chkCnt,
							   "fk_receiveuser_num":${fk_receiveuser_num} },
				dataType:"JSON",
				success:function(json){
					
					var result = json.result;
					
					if(result != 1) {
						alert("메일 삭제에 실패했습니다.");
						window.location.reload();
					}
					else {
						alert("메일 삭제에 성공했습니다.");
						window.location.reload();
					}
					
				},
				
				error: function(request, status, error) {
					alert("code:"+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
					
				}
				
			});
			
		}
		
	}
	
</script>

<%-- 받은 메일함 목록 보여주기 --%>	
<div class="container" style="width: 100%; margin: 50px;">
	<div class="row bg-title" style="border-bottom: solid 1.5px #e6e6e6;">	
		<div class="col-lg-3 col-md-4 col-sm-4 col-xs-12">
			<h4 class="page-title" style="color: black;">휴지통</h4>
		</div>
		
		<form name="goRecyclebinListSelectFrm" style="display: inline-block; padding-left: 470px;">		
			<div id="mail_searchType">
				<select class="form-control" id="searchType" name="searchType" style="">
					<option value="subject" selected="selected">제목</option>
					<option value="sendempname">보낸이</option>
				</select>
			</div>
			
			<div id="mail_serachWord">
				<input id="searchWord" name="searchWord" type="text" class="form-control" placeholder="내용을 입력하세요.">
			</div>
			
			<button type="button" style="margin-bottom: 5px" id="btnSearch" class="btn btn-secondary" onclick="gomailSearch()">
				<i class="fa fa-search" aria-hidden="true" style="font-size:15px;"></i>
			</button>
		</form>				
	</div>
	
	<div class="row">
		<div class="col-sm-12">
			<div class="white-box" style="padding-top: 5px;">
				<div id="secondHeader">
					<ul id="secondHeaderGroup" style="padding: 0px; margin-left: -10px;">
						<li class="secondHeaderList">
							<button type="button" id="delTrash" onclick="goMailDelRecyclebin()">
							<i class="fa fa-trash-o fa-fw"></i>
								영구삭제
							</button>
						</li>
						<li class="secondHeaderList">
							<button type="button" id=readReceive onclick="goReadReceive()">
							<i class="fa fa-envelope-o fa-fw"></i>
								읽음
							</button>
						</li>
					</ul>
				</div>
				
				<div class="table-responsive" style="color: black;">
					<table>
						<thead>
							<tr>
								<th style="width: 2%;">
									<input type="checkbox" id="checkAll" />
								</th>
								<th style="width: 2%;">
									<span class="fa fa-star-o"></span>
								</th>
								<th style="width: 2%;">
									<span class="fa fa-paperclip"></span>
								</th>
								<th style="width: 10%;" class="text-center">보낸이</th>
								<th style="width: 70%;">제목</th>
								<th style="width: 20%;" class="text-left">날짜</th>
							</tr>
						</thead>
						
						<tbody>
						<c:forEach items="${requestScope.RecyclebinMailList}" var="RecyclebinMailList">
							<tr>
								<td style="width: 40px;">
									<input type="checkbox" id="${RecyclebinMailList.pk_mail_num}" name="chkBox" class="text-center"/>
								</td>
								<td style="width: 40px;">
									<c:if test="${RecyclebinMailList.importance == '1'}">
									<span class="fa fa-star" class="text-center"></span>
									</c:if>									
									<c:if test="${RecyclebinMailList.importance == '0'}">
									<span class="fa fa-star-o" class="text-center"></span>
									</c:if>
								</td>
								<td style="width: 40px;">
									<c:if test="${not empty RecyclebinMailList.filename}">
										<span class="fa fa-paperclip" class="text-center"></span>
									</c:if>								
								</td>							
								<td class="text-center">${RecyclebinMailList.sendempname}</td>
								<td>
								<%--
								<a href="<%= ctxPath%>/mail/mailReceiveDetail.bts?searchType=${}&searchWord=${}&pk_mail_num=${}">${receiveMailList.subject}</a>
								--%>
									<span class="subject" onclick="goRecMailView('${RecyclebinMailList.pk_mail_num}')">
										<c:if test="${RecyclebinMailList.importance == '1'}">
											<span class="fa fa-exclamation" style="color: red;" class="text-center"></span>
										</c:if>	
										${RecyclebinMailList.subject}
									</span>
								</td>
								<td class="text-left">
									<c:if test="${not empty RecyclebinMailList.reservation_date}">
										${RecyclebinMailList.reservation_date}:00
									</c:if>
									<c:if test="${empty RecyclebinMailList.reservation_date}">
										${RecyclebinMailList.reg_date}
									</c:if>									
								</td>
							</tr>	
						</c:forEach>																				
						</tbody>
					</table>
				</div>	
				
				<%-- 페이징 처리하기 --%>
				<div align="center" style="border: solid 0px gray; width: 70%; margin: 20px auto;" >
					${requestScope.pageBar}
				</div>							
			</div>
		</div>	
	</div>
</div>