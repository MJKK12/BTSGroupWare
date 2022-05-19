<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
    
<%
    String ctxPath = request.getContextPath();
    //    /bts
%>

<style type="text/css">

#tbl_telAdd { 
      border-collapse: separate;
      border-spacing: 0 12px;
   }
<%--    
   .arrow-next_1 {
    position: relative;
    float:left;
    width:90px;
    height:90px;
}

.arrow-next_1::after {
    position: absolute;
    left: 10px; 
    top: 20px; 
    content: '';
    width: 50px; /* 사이즈 */
    height: 50px; /* 사이즈 */
    border-top: 5px solid #000; /* 선 두께 */
    border-right: 5px solid #000; /* 선 두께 */
    transform: rotate(45deg); /* 각도 */
}


   .arrow-next_2 {
    position: relative;
    float:left;
    width:90px;
    height:90px;
}

.arrow-next_2::after {
    position: absolute;
    left: 10px; 
    top: 20px; 
    content: '';
    width: 50px; /* 사이즈 */
    height: 50px; /* 사이즈 */
    border-top: 5px solid #000; /* 선 두께 */
    border-right: 5px solid #000; /* 선 두께 */
    transform: rotate(45deg); /* 각도 */
}
--%>
/* ----------------------------------------------------  */

</style>


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
     
   
   }); // end of $( document ).ready( function()------------------------------------------
    


//--------------------------- 중간결재자 버튼 시작 ---------------------------// 
      function middle_approve(){
         
         var empno = [];
         var name = [];
         var rank = [];
         var dept = [];
          $("input[name='empno']:checked").each(function() {
              id = $(this).attr('id')
              empno.push($(this).val());
              name.push($("#employee_name_" + id.split('_')[3]).val())
              rank.push($("#employee_rank_" + id.split('_')[3]).val())
              dept.push($("#employee_dept_" + id.split('_')[3]).val())
          });
          
          $("#mid_emp").empty()
          
          for(var i=0; i<empno.length; i++){
             
             var html = ""
             html += '<tr><td><input type="hidden" value = ' + empno[i] + '></td>'
             html += '<td><input type="text" style="text-align:center; border:none;" id="mid_text_name_' + i + '"  readonly value = ' + name[i] + '></td>'
             html += '<td><input type="text" style="text-align:center; border:none;" id="mid_text_rank_' + i + '" readonly value = ' + rank[i] + '></td>'
             html += '<td><input type="text" style="text-align:center; border:none;" id="mid_text_dept_' + i + '" readonly value = ' + dept[i] + '></td></tr>'
             
             $("#tbl_middle > tbody:last").append(html)
          }
      }   
//--------------------------- 중간결재자 버튼 끝 ---------------------------//   

//--------------------------- 최종결재자 버튼 시작 ---------------------------//
      function last_approve(){
         
         var empno = [];
         var name = [];
         var rank = [];
         var dept = [];
          $("input[name='empno']:checked").each(function(){
              id = $(this).attr('id')
              empno.push($(this).val());
              name.push($("#employee_name_" + id.split('_')[3]).val())
              rank.push($("#employee_rank_" + id.split('_')[3]).val())
              dept.push($("#employee_dept_" + id.split('_')[3]).val())
              
          });
          
          $("#last_emp").empty()
          
          for(var i=0; i<empno.length; i++){
             
             var html = ""
             html += '<tr><td><input type="hidden" value = ' + empno[i] + '></td>'
             html += '<td><input type="text" style="text-align:center; border:none;" id="last_text_name_' + i + '" readonly value = ' + name[i] + '></td>'
             html += '<td><input type="text" style="text-align:center; border:none;" id="last_text_rank_' + i + '" readonly value = ' + rank[i] + '></td>'
             html += '<td><input type="text" style="text-align:center; border:none;" id="last_text_dept_' + i + '" readonly value = ' + dept[i] + '></td></tr>'
             
             $("#tbl_last > tbody:last").append(html)
          }
          
      }
//--------------------------- 최종결재자 버튼 끝 ---------------------------//      
   
//--------------------------- 모달 등록 버튼 시작(여길 누르면 input에 값이 담김) ---------------------------//

   function goApprove() {
   
	   var empno = [];
       var name = [];
       var rank = [];
       var dept = [];
        $("input[name='empno']:checked").each(function(){
            id = $(this).attr('id')
            empno.push($(this).val());
            name.push($("#employee_name_" + id.split('_')[3]).val())
            rank.push($("#employee_rank_" + id.split('_')[3]).val())
            dept.push($("#employee_dept_" + id.split('_')[3]).val())
            
        });
	
        
	   for(var i=0; i<empno.length; i++){
		   
		   var mid_html = ""
	             mid_html += '<tr><td><input type="hidden" value = ' + empno[i] + '></td>'
	             mid_html += '<td><input type="text" style="text-align:center; border:none;" id="mid_text_name_' + i + '" name="last_text_name_' + i + '" readonly value = ' + name[i] + '></td>'
	             mid_html += '<td><input type="text" style="text-align:center; border:none;" id="mid_text_rank_' + i + '" name="last_text_rank_' + i + '" readonly value = ' + rank[i] + '></td>'
	             mid_html += '<td><input type="text" style="text-align:center; border:none;" id="mid_text_dept_' + i + '" name="last_text_dept_' + i + '" readonly value = ' + dept[i] + '></td></tr>'
		   
		   var last_html = ""
			   last_html += '<tr><td><input type="hidden" value = ' + empno[i] + '></td>'
			   last_html += '<td><input type="text" style="text-align:center; border:none;" id="last_text_name_' + i + '" name="last_text_name_' + i + '" readonly value = ' + name[i] + '></td>'
			   last_html += '<td><input type="text" style="text-align:center; border:none;" id="last_text_rank_' + i + '" name="last_text_rank_' + i + '" readonly value = ' + rank[i] + '></td>'
			   last_html += '<td><input type="text" style="text-align:center; border:none;" id="last_text_dept_' + i + '" name="last_text_dept_' + i + '" readonly value = ' + dept[i] + '></td></tr>'
             
             $("#test_tbl > #tbody1").append(mid_html)
             $("#test_tbl > #tbody2").append(last_html)
		  /* 
		   	$("#mid_test_"+(i+1)).val($("#mid_text_name_"+i).val());
			$("#last_test_"+(i+1)).val($("#last_text_name_"+i).val());
		  */ 
		}
	   
   }

//--------------------------- 모달 등록 버튼 끝(여길 누르면 input에 값이 담김) ---------------------------//   

/* ------ 여길 누르면 값이 컨트롤러 단으로 넘어감 ------ */
<%--
function test() {
	const frm = document.testFrm;
    frm.action = "<%=ctxPath%>/addBook/orgChart_sample.bts"
    frm.method = "post"
	frm.submit();
}
--%>
function test(i)	{
	$.ajax({
		url:"<%= ctxPath%>/addBook/orgChart_sample.bts",
		data:{"test_1" : $("#last_text_name_0").val() ,
			  "test_2" : $("#last_text_name_1").val() ,
			  "test_3" : $("#last_text_name_2").val() ,
			},
		type: "post",
		dataType: 'json',
		success : function(json) {
			
		},
		error: function(request){
			
		}
	});
}


/* ------ 여길 누르면 값이 컨트롤러 단으로 넘어감 ------ */

</script>

<title>조직도 틀 샘플</title>










   
   
  <form name="testFrm">
 <table id="test_tbl">
 <!--  
 <input type="text" id="mid_test_1" name="mid_test_1" > 
 <input type="text" id="mid_test_2" name="mid_test_2" > 
 <input type="text" id="mid_test_3" name="mid_test_3" > 
 
 <input type="text" id="last_test_1" name="last_test_1" > 
 <input type="text" id="last_test_2" name="last_test_2" > 
 <input type="text" id="last_test_3" name="last_test_3" > 
 -->
 <tbody id="tbody1">
 	<tr>
 </tbody>
 <tbody>
 	<tr>
 </tbody>
 
 </table>
 </form>
 <button type="submit" onclick="test()">넘어가라</button>
 
<button class="btn btn-default" data-toggle="modal" data-target="#viewModal">유리한테 줄 조직도 틀</button>


<!-- 모달 -->
<div class="modal fade" data-backdrop="static" id="viewModal">
   <div class="modal-dialog">
   <div class="modal-content" style= "height:90%; width:200%;">
   <div class="modal-header">
   <h4 class="modal-title" id="exampleModalLabel">결재 참조</h4>
   </div>
   
   <div class="modal-body">
      <div id="tbl_one" style="float:left; width:22%;">
         <table style="text-align:center;">
            <tr>
               <td><button class="btn btn-default" id="y_team" style="width:150px; border: solid darkgray 2px;">영업팀</button></td>
            </tr>
            <c:forEach var="emp" items="${requestScope.empList}" varStatus="i">
            <c:if test="${emp.ko_depname  eq '영업'}">
            <tr>
            <td>
               <div id="y_teamwon">
                  <label>
                     <input type="checkbox" id="pk_emp_no_${i.count}" name="empno" value="${emp.pk_emp_no}" />
                     <input type="hidden" id="employee_name_${i.count}" name="employee_name" value="${emp.emp_name}" />
                     <input type="hidden" id="employee_rank_${i.count}" name="employee_rank" value="${emp.ko_rankname}" />
                     <input type="hidden" id="employee_dept_${i.count}" name="employee_dept" value="${emp.ko_depname}" />
                     &nbsp;${emp.emp_name}&nbsp;[${emp.ko_rankname}]
                  </label>
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
                  <label>
                     <input type="checkbox" id="pk_emp_no_${i.count}" name="empno" value="${emp.pk_emp_no}" />
                     <input type="hidden" id="employee_name_${i.count}" name="employee_name" value="${emp.emp_name}" />
                     <input type="hidden" id="employee_rank_${i.count}" name="employee_rank" value="${emp.ko_rankname}" />
                     <input type="hidden" id="employee_dept_${i.count}" name="employee_dept" value="${emp.ko_depname}" />
                     &nbsp;${emp.emp_name}&nbsp;[${emp.ko_rankname}]
                  </label>
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
                  <label>
                     <input type="checkbox" id="pk_emp_no_${i.count}" name="empno" value="${emp.pk_emp_no}" />
                     <input type="hidden" id="employee_name_${i.count}" name="employee_name" value="${emp.emp_name}" />
                     <input type="hidden" id="employee_rank_${i.count}" name="employee_rank" value="${emp.ko_rankname}" />
                     <input type="hidden" id="employee_dept_${i.count}" name="employee_dept" value="${emp.ko_depname}" />
                     &nbsp;${emp.emp_name}&nbsp;[${emp.ko_rankname}]
                  </label>
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
                  <label>
                     <input type="checkbox" id="pk_emp_no_${i.count}" name="empno" value="${emp.pk_emp_no}" />
                     <input type="hidden" id="employee_name_${i.count}" name="employee_name" value="${emp.emp_name}" />
                     <input type="hidden" id="employee_rank_${i.count}" name="employee_rank" value="${emp.ko_rankname}" />
                     <input type="hidden" id="employee_dept_${i.count}" name="employee_dept" value="${emp.ko_depname}" />
                     &nbsp;${emp.emp_name}&nbsp;[${emp.ko_rankname}]
                  </label>
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
                  <label>
                     <input type="checkbox" id="pk_emp_no_${i.count}" name="empno" value="${emp.pk_emp_no}" />
                     <input type="hidden" id="employee_name_${i.count}" name="employee_name" value="${emp.emp_name}" />
                     <input type="hidden" id="employee_rank_${i.count}" name="employee_rank" value="${emp.ko_rankname}" />
                     <input type="hidden" id="employee_dept_${i.count}" name="employee_dept" value="${emp.ko_depname}" />
                     &nbsp;${emp.emp_name}&nbsp;[${emp.ko_rankname}]
                  </label>
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
                  <label>
                     <input type="checkbox" id="pk_emp_no_${i.count}" name="empno" value="${emp.pk_emp_no}" />
                     <input type="hidden" id="employee_name_${i.count}" name="employee_name" value="${emp.emp_name}" />
                     <input type="hidden" id="employee_rank_${i.count}" name="employee_rank" value="${emp.ko_rankname}" />
                     <input type="hidden" id="employee_dept_${i.count}" name="employee_dept" value="${emp.ko_depname}" />
                     &nbsp;${emp.emp_name}&nbsp;[${emp.ko_rankname}]
                  </label>
               </div>
            </td>
            </tr>
            </c:if>
               </c:forEach>
           </table>
        </div>
        
        <div id="tbl_two" style="float:left; width:20%; margin-top:7%;">
           <table>
              <tr><td><button class="form-control" style="height:70px;" onclick="middle_approve();" >중간결재<br>추가  / 삭제</button></td></tr>
              <tr><td><button class="form-control" style="height:70px; margin-top:170%;" onclick="last_approve();">최종결재<br>추가  / 삭제</button></td></tr>
           </table>
        </div>
        
        <div id="tbl_three" style="float:left; width:50%;">
           <form name="submitFrm">
           <table id = "tbl_middle" style="text-align:center;">
              <tr><td colspan="7">중간 결재</td></tr>
            <tr style="border: solid darkgray 2px; margin-left:2%">
               <td style="width:0%;"><input type="hidden" id="pk_emp_no_${i.count}" name="pk_emp_no_${i.count}" value="${emp.pk_emp_no}" readonly /></td>
               <td style="width:13%;"><strong>이름</strong></td>
               <td style="width:13%;"><strong>직급</strong></td>
               <td style="width:13%;"><strong>부서</strong></td>
            </tr>
            <tbody id = "mid_emp">
               <tr style="border-bottom: solid darkgray 2px;">
                  <td style="width:0%;"><input type="hidden" id="pk_emp_no_${i.count}" name="pk_emp_no_${i.count}" value="${emp.pk_emp_no}" readonly />
                  <input type="hidden" id="middle_empno" name="middle_empno"  style="border:none; text-align:center; " ></td>
                  <td><input type="text" id="middle_name" name="middle_name"  style="border:none; text-align:center; " ><br></td>
                  <td><input type="text" id="middle_rank" name="middle_rank"  style="border:none; text-align:center;" ><br></td>
                  <td><input type="text" id="middle_dept" name="middle_dept"  style="border:none; text-align:center;"  ><br></td>
               </tr>
            </tbody>
         </table>
         <table id="tbl_last" style="text-align:center; margin-top:30%;">
            <tr><td colspan="7">최종 결재</td></tr>
            <tr style="border: solid darkgray 2px; margin-left:2%">
               <td style="width:0%;"><input type="hidden" id="pk_emp_no_${i.count}" name="pk_emp_no_${i.count}" value="${emp.pk_emp_no}" readonly /></td>
               <td style="width:13%;"><strong>이름</strong></td>
               <td style="width:13%;"><strong>직급</strong></td>
               <td style="width:13%;"><strong>부서</strong></td>
            </tr>
            <tbody id = "last_emp">
               <tr style="border-bottom: solid darkgray 2px;">
                  <td style="width:0%;"><input type="hidden" id="pk_emp_no_${i.count}" name="pk_emp_no_${i.count}" value="${emp.pk_emp_no}" readonly />
                  <input type="hidden" id="last_empno" name="last_empno"  style="border:none; text-align:center; " ></td>
                  <td><input type="text" id="last_name" name="last_name"  style="border:none; text-align:center; " ><br></td>
                  <td><input type="text" id="last_rank" name="last_rank"  style="border:none; text-align:center;" ><br></td>
                  <td><input type="text" id="last_dept" name="last_dept"  style="border:none; text-align:center;"  ><br></td>
               </tr>
            </tbody>   
         </table>
         </form>
        </div>
   </div><!-- modal-body -->
   
   <div class="modal-footer">
   <input type="button" class="btn btn-primary" id="insert_customer_btn" onclick="goApprove()" value="등록">
   <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
   </div>
   </div>
   </div>
   </div>