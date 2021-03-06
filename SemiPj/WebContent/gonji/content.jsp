<%@page import="java.text.SimpleDateFormat"%>
<%@page import="data.dto.GonjiDto"%>
<%@page import="data.dao.GonjiDao"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<!-- 메인페이지에 필요한 링크/부트스트랩  -->
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">

<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<style type="text/css">
	/* #cl-dashboard{display: none;} */
	
/*폰트 */
@import url('https://fonts.googleapis.com/css2?family=Noto+Serif+KR:wght@300&display=swap');

	body{
		display: flex;
		width: 100%;
		margin-left: 230px;	
		font-family: 'Noto Serif KR', serif;
	}
</style>
</head>
<body>
<%
	//이부분이 formaction의 String path="../index.jsp?main=gonji/content.jsp?num="
	//에서 변수명이 마지막 num으로 넘어감
	String gonnum=request.getParameter("num");	
	String pageNum=request.getParameter("pageNum");
	String key=request.getParameter("key");
	
	//key 값이 널값이 아니면서 'list' 일경우 
	//(이유:수정후에도 content.jsp 로 오기때문에 목록에서
    //			올 경우에만 증가함)
	//조회수 증가
	GonjiDao db=new GonjiDao();
	if(key!=null && key.equals("list"))
		db.updateReadcount(gonnum);
	
	//번호에 해당하는 dto 가져오기
	GonjiDto dto=db.getData(gonnum);
	System.out.println(dto.getGonwriteday());
	//mysql에서는 시간까지 나오게 하려면 datetime이어야 한다
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>	
<table class="table table-striped" style="width: 1000px;">
	<tr>
		<td width="650">
			<b><%=dto.getGonsubject()%></b>
		</td>
		<td>
			<span style="color: #ccc;font-size: 9pt;float: right;">
			<%=sdf.format(dto.getGonwriteday())%></span>
		</td>
	</tr>
	<tr height="350">
		<td colspan="2" valign="top">
			<img src="image/chr15.gif" width="30">
			<b><%=dto.getGonid()%></b>
			<br><br>			
			<pre><%=dto.getGoncontent()%></pre>	
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<span style="color: gray;font-size: 9pt;float: right;">
			조회수&nbsp; <%=dto.getGonreadcount()%>
			</span>			
		</td>
	</tr>
	<tr>
		<td colspan="2" align="right">
			<input type="button" class="btn btn-warning btn-xs"
			  value="글쓰기" style="width: 120px;"
			  onclick="location.href='index.jsp?main=gonji/gonjiform.jsp'">
			<input type="button" class="btn btn-info btn-xs"
			  value="글목록" style="width: 120px;"
			  onclick="location.href='index.jsp?main=gonji/gonjilist.jsp?pageNum=<%=pageNum%>'">			
		</td>
	</tr>	
</table>
</body>
</html>