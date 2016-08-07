<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" type="text/css" href="Tabela.css">
	
	<title>Insert title here</title>
</head>
<body>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
		
	<c:import url="cabecalho.jsp" />
		
	<table>
		<tr>
				<th>Nome</th>
				<th>Login</th>
		</tr>

		<tr>
		 	<td>${usuario.nome}</td>
		 	<td>${usuario.login}</td>
		</tr>
	</table>
	<br /><br />
	<form action="mvc">
			<input type="hidden" name="logica" value="AlteraUsuarioLogic">
			Nome: <input type="text" name="nome" value="${usuario.nome}"/><br /><br />
			Login: <input type="text" name="login" value="${usuario.login}" /><br /><br />
			Senha: <input type="password" name="senha" value="${usuario.senha}" /><br /><br />
			Grupo:<select name="grupo" value="${usuario.grupo}">
			  <option value="Administrador">Administrador</option>
			  <option value="Comum">Comum</option>
			</select>
			<br /><br />
			<input type="hidden" name="id" value="${usuario.id}">
			
			<input type="submit" value="Alterar" />
	</form>
	
	<c:import url="rodape.jsp" />
</body>
</html>