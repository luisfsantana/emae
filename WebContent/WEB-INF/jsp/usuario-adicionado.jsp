<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Sucesso</title>
</head>
<body>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	<c:import url="cabecalho.jsp" />
	
	
	<h2>Usuário Adicionado!</h2>
	<form action=mvc>
		<input type="text" name="logica" hidden="true" value="ListaUsuariosLogic">
		<input type="submit" value="Mostrar Usuários" />
	</form>
		
	<c:import url="rodape.jsp" />
	
</body>
</html>