<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	<c:import url="/WEB-INF/jsp/cabecalho-logado.jsp" />
	
	
	<h2>Usuario Adicionado!</h2>
	<form action=mvc>
		<input type="hidden" name="logica" value="ListaTarefasLogic">
		<input type="submit" value="Mostrar Tarefas" />
	</form>
		
	<c:import url="/WEB-INF/jsp/rodape.jsp" />
</body>
</html>