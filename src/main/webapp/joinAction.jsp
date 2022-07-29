<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import = "user.UserDAO"%>
<%@ page import = "java.io.PrintWriter" %>

<% 	request.setCharacterEncoding("UTF-8");%>
<jsp:useBean id = "user" class="user.User" scope = "page" />
<jsp:setProperty name = "user" property = "userID"  />
<jsp:setProperty name = "user" property = "userPassWord" />
<jsp:setProperty name = "user" property = "userName" />
<jsp:setProperty name = "user" property = "userGender" />
<jsp:setProperty name = "user" property = "userEmail" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>ㄴㅇ라ㅓㄴ</title>
<body>
<% 
String userID = null;
if(session.getAttribute("userID") != null){
	userID = (String) session.getAttribute("userID");
}
if(userID !=null){
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('이미 로그인이 되어있습니다.')");  // 로그인 된 사람은 회원가입 못하게 함
	script.println("location.href = 'main.jsp'");
	script.println("</script>");
}

	if (user.getUserID() == null || user.getUserPassWord() == null || user.getUserName() == null
		|| user.getUserGender() == null || user.getUserEmail() == null) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안 된 사항이 있습니다.')");
				script.println("history.back()");
				script.println("</script>");
} else{
	UserDAO userDAO = new UserDAO();
    int result = userDAO.join(user);
	if(result == -1){ 
		

		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('아이디가 존재합니다.');");
		script.println("history.back();");
		script.println("</script>");
	
		
	}
	else {
		session.setAttribute("userID", user.getUserID());
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = 'main.jsp'");
		script.println("</script>");


		
	}
}
	
	
	

	
%>
</body>
</html>