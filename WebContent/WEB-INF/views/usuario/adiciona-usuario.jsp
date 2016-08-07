<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Adiciona Usuário</title>
</head>
<body>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	
		<c:import url="/WEB-INF/jsp/cabecalho.jsp" />
	
		<div  style="position: absolute; left: 100px;">
		<h2>Cadastrar Usuário</h2>
		<form action="adicionaUsuario" method="post" >
			
			Nome de Usuário:&nbsp; <input type="text" name="nome" size="50"/>
			<form:errors path="usuario.nome" cssStyle="color:red"/>
	
			<br /><br />
			
			Login: <input type="text" name="login" size="35"/>
			<form:errors path="usuario.login" cssStyle="color:red"/>
	
			<br /><br />
			Senha:&nbsp; <input type="password" name="senha" size="10"/>
			<form:errors path="usuario.password" cssStyle="color:red"/>
	
			<br /><br />
			Confirmar Senha:&nbsp; <input type="password" name="senhavalidacao" size="10"/>
			<form:errors path="usuario.password" cssStyle="color:red"/>
	
			<br /><br />
			Grupo:&nbsp; <select name="grupo">
			  <option value="Administrador">Administrador</option>
			  <option value="Comum" selected>Comum</option>
			</select>
			<br /><br />
			
			<input type="submit" value="Gravar" size="20"/>
		</form>
		</div>
		<br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
		<c:import url="/WEB-INF/jsp/rodape.jsp" />
</body>
</html>