<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Área do Usuário</title>
</head>
<body>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	<c:import url="cabecalho-logado.jsp" />
	
	<div align="center">
		<h2>Login feito com sucesso! Bem vindo ${usuario.nome}!</h2>
		<form action=mvc>
			<input type="hidden" name="logica" value="ExibiListaTarefasUsuarioLogic">
			<input type="hidden" name="id_usuario" value="${usuario.id}"><br />
			<input type="submit" value="Minhas Tarefas" style="height:100px; width:200px"/>
		</form>
		
		<form action=mvc>
			<input type="hidden" name="logica" value="ListaTarefasLogic">
			<input type="submit" value="Todas as Tarefas" style="height:100px; width:200px"/>
		</form>
		
		<form action=mvc>
			<input type="hidden" name="logica" value="AdicionaTarefaLogic">
			<input type="hidden" name="id_usuario" value="${usuario.id}"><br />
			<input type="submit" value="Criar minha Tarefa" style="height:100px; width:200px"/>
		</form>
		
		
		<!--  Carregar  todos os usuários cadastrados em um select-->
		<form action=mvc>
			<input type="hidden" name="logica" value="CriarTarefaParaLogic">
			<input type="hidden" name="id_usuario" value="${usuario.id}"><br />
			Criar Tarefa Para: <select name="tarefa_para">
			  <optgroup collection="${usuarios.nome}"> </option>
			</select>
						
			
			<input type="submit" value="Criar Tarefa Para" style="height:100px; width:200px"/>
		</form>
		
		
	</div>	
	<c:import url="rodape.jsp" />
</body>
</html>