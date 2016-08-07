<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" type="text/css" href="Tabela.css">
	
	<title>P�gina Inicial Mafes</title>
</head>
<body>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	<c:import url="/WEB-INF/jsp/cabecalho.jsp" />
	
	<div align="center">
		<h3>Mafes Intelig�ncia Agron�mica <br/> <br/>
		<a href="http://localhost:8080/MemoriaMafes/login.jsp">Login</a><br /><br />
		<a href="http://localhost:8080/MemoriaMafes/adiciona-usuario.jsp">Adicionar Usu�rio</a><br /><br />
		<a href="http://localhost:8080/MemoriaMafes/adiciona-tarefa.jsp">Adicionar Tarefa</a><br /><br />
		<a href="http://localhost:8080/MemoriaMafes/adiciona-peca.jsp">Adicionar Peca</a>
		</h3>
	</div>
	
	<c:import url="/WEB-INF/jsp/rodape.jsp" />
	
</body>
</html>