<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" type="text/css" href="Tabela.css">
	<title>Lista Usuários do Sistema</title>
</head>
<body>
		<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
		<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
		
		<c:import url="cabecalho.jsp" />
		
		<table border="1">
			<tr>
				<th>Nome</th>
				<th>Login</th>
			</tr>
			 
			<!-- percorre contatos montando as linhas da tabela -->
			<c:forEach var="usuario" items="${usuarios}">
				<tr>
				 	<td>${usuario.nome}</td>
					<td>${usuario.login}</td>
				 	<td>
      					<a href="mvc?logica=RemoveUsuarioLogic&id=${usuario.id}">Remover</a>
    				</td>	
    				
    				<td>
      					<a href="mvc?logica=MostraUsuarioLogic&id=${usuario.id}">Alterar</a>
    				</td>		
    					
				</tr>
			
			</c:forEach>
		</table>
		
		<c:import url="rodape.jsp" />
	
</body>
</html>