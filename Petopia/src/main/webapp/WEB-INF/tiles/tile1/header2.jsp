<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String cxtPath = request.getContextPath();
%>
    
<script type="text/javascript">

	$(document).ready(function(){
		
		$(".search_submit").click(function(){
			
			goSearchbyword();
			
		});
		
		
		$(".search").keydown(function(){
			
			if(event.KeyCode == 13) {
				goSearchbyword();
			}
			
		});
		
	});
	
	function goSearchbyword() {

		
		
	};
	

</script>


<nav class="navbar navbar-default navbar-fixed-top">
  <div class="container">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span> 
      </button>
      <a class="navbar-brand" href="<%= cxtPath %>/home.pet">PETOPIA</a>
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav navbar-right">
        <li><a href="<%= cxtPath %>/join.pet">회원가입</a></li>
        <li><a href="<%= cxtPath %>/login.pet" >로그인</a></li>
        <li><a href="<%= cxtPath %>/logout.pet">로그아웃</a></li>
        <li class="dropdown">
	        <a class="dropdown-toggle" data-toggle="dropdown" href="#">마이페이지
	        <span class="caret"></span></a>
	        <ul class="dropdown-menu">
	          <li><a href="#">반려동물수첩</a></li>
	          <li><a href="#">나의정보보기</a></li>
	          <li><a href="#">나의병원리뷰</a></li>
	          <li><a href="#">나의병원관리</a></li>
	        </ul>
        </li>
      </ul>
    </div>
  </div>
</nav>


<div class="jumbotron text-center">
	<h1>PETOPIA</h1> 
	<p>동물병원/약국 검색·예약·결제, 나의 반려동물 관리까지 한번에</p>
	<form class="form-inline justify-content-center">
		<div class="input-group search">
		    <input id="inputlg" type="text" class="form-control input-lg" placeholder="이름/지역 검색">
		    <div class="input-group-btn">
		      <button id="inputlg" class="btn btn-default input-lg search_submit" type="submit">
		        <i class="glyphicon glyphicon-search"></i>
		      </button>
		    </div>
		</div>
	</form>
</div>


</body>
</html>