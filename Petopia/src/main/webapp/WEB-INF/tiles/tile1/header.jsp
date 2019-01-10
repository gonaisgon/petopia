<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ page import="java.net.InetAddress" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<%-- ======= #25. tiles1 중 header 페이지 만들기  ======= --%>
<%
	String cxtPath = request.getContextPath();

	//=== 서버 IP 주소 알아오기 === //
	InetAddress inet = InetAddress.getLocalHost();
	String serverIP = inet.getHostAddress(); 
	int portnumber = request.getServerPort();
	
	String serverName = "http://"+serverIP+":"+portnumber;
%>


<script type="text/javascript">

	$(document).ready(function(){
	    $('[data-toggle="popover"]').popover();
	    
	});

	
</script>




<div class="jumbotron jumbotron-fluid" style="width: 100%; height: 320px; border-radius: 10px; background-color: transparent; background-image: url('<%= cxtPath %>/resources/img/homeheader/homeheader2_morecrop.jpg'); background-size: cover;">
	<div class="container" align="right">
		<div class="buttons" >
	 	  	<button type="button" class="btn" style="background-color: #ff6e60; color:white;">회원가입</button>
	 	  	<button type="button" class="btn" style="background-color: gray; color:white;" onclick="javascript:location.href='<%= cxtPath %>/login.pet'">로그인</button>
	 	  	<button type="button" class="btn btn-warning" onclick="javascript:location.href='<%= cxtPath %>/logout.pet'">로그아웃</button>
	 	  	<a href="#" data-toggle="popover" title="이고은님 환영합니다" data-content="<a href='<%= cxtPath %>/diary.pet?idx=${ loginuser.idx }'>반려동물수첩</a><br/><a href='<%= cxtPath%>/info.pet'>나의정보보기</a><br/><a href='<%= cxtPath%>/myreview.pet?idx=${ loginuser.idx}'>나의병원리뷰</a><br/><a href='<%= cxtPath%>/myhospital.pet?idx=${ loginuser.idx}'>나의병원관리</a>" data-html="true" data-placement="auto" style="border: 0px;"><img src="<%= cxtPath%>/resources/img/homeheader/user.png" style="width:30px; height: 30px;"/></a>
 	  	</div>
 	  	<div class="h1_companyname">
 	  		<h1 style="font-weight: bold;"><span style="color: #3b5998">PET</span><span style="color: orange;">O</span><span style="color: rgb(252, 118, 106)">PIA</span></h1>
 	  	</div>
 	  	<div class="search">
			<form name="searchFrm">
			  <input type="text" id="searchWord" name="searchWord" placeholder="이름/위치 검색" >
			</form>
 	  	</div>
   	</div>
</div>
