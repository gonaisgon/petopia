<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String cxtPath = request.getContextPath();
%>
    
<script type="text/javascript">
	

</script>

<div class="header">
<nav class="navbar navbar-default navbar-fixed-top">
  <div class="container">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span> 
      </button>
      <a class="navbar-brand logo" href="<%= cxtPath %>/home.pet">PETOPIA</a>
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
</div>



</body>
</html>