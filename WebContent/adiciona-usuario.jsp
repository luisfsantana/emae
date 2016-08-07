<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Cadastro Usuário</title>
</head>
<body>

		<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	
		<c:import url="/WEB-INF/jsp/cabecalho.jsp" />
	
		<div style="position: absolute; left: 100px;" >		
		<h1>Cadastrar Usuário</h1>
		<hr />
		<form action="mvc" >
			<input type="hidden" name="logica" value="AdicionaUsuarioLogic">
			Nome: <input type="text" name="nome" size="50"/><br /><br />
			Login: <input type="text" name="login" size="35"/><br /><br />
			Senha: <input type="password" name="senha" size="10"/><br /><br />
			Confirmar Senha: <input type="password" name="senha" size="10"/><br /><br />
			Grupo: <select name="grupo">
			  <option value="Administrador">Administrador</option>
			  <option value="Comum">Comum</option>
			</select>
			<br /><br />
			
			<input type="submit" value="Gravar" size="20"/>
		</form>
		</div>
		
		<c:import url="/WEB-INF/jsp/rodape.jsp" />
		
</body>
</html>