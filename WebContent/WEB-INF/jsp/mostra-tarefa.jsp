<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<link href="css/jquery-ui.css" rel="stylesheet">
	    <script src="js/jquery.js"></script>
	    <script src="js/jquery-ui.js"></script>
		<link rel="stylesheet" type="text/css" href="Tabela.css">
	
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Detalhes da Tarefa</title>
	</head>
<body>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
	<%@taglib tagdir="/WEB-INF/tags" prefix="mafes" %>
    	
	<c:import url="cabecalho-logado.jsp" />
		
	<table>
		<tr>
				<th>Prioridade</th>
				<th>Status</th>
				<th>Nome</th>
				<th>Observações</th>
				<th>Data Inicio</th>
				<th>Data Fim</th>
				<th>Responsável</th>
				
		</tr>

		<tr>
		 	<td>${tarefa.prioridade}</td>
		 	<td>${tarefa.status}</td>
		 	<td>${tarefa.nome}</td>
		 	<td>${tarefa.observacao}</td>
		 	<td><fmt:formatDate value="${tarefa.dataInicio.time}" pattern="dd/MM/yyyy"/></td>
			<td><fmt:formatDate value="${tarefa.dataFim.time}" pattern="dd/MM/yyyy"/></td>
		 	<td>${tarefa.responsavel}</td>
		 	
		</tr>
	</table>
	
	<form action="mvc">
			<input type="hidden" name="logica" value="AlteraTarefaLogic">
			Prioridade: <select name="prioridade" value="${tarefa.prioridade}">
			  <option value="1" selected>1</option>
			  <option value="2">2</option>
			  <option value="3">3</option>
			</select>
			<br />
			Status: <input type="text" name="status" value="${tarefa.status}" /><br />
			Nome: <input type="text" name="nome" value="${tarefa.nome}" />
			Observações: <input type="text" name="observacao" value="${tarefa.observacao}"/><br />
			
			<fmt:formatDate value="${tarefa.dataInicio.time}" pattern="dd/MM/yyyy" var="theFormattedDate" /> <br />
			Data Inicio: <mafes:campoData id="datainicio" value="${theFormattedDate}"/><br /><br />
			
			<fmt:formatDate value="${tarefa.dataFim.time}" pattern="dd/MM/yyyy" var="theFormattedDate1" /> <br />
			Data Fim: <mafes:campoData id="datafim" value="${theFormattedDate1}"/><br /><br />
			
			Responsável: <input type="text" name="responsavel" value="${tarefa.responsavel}" />
			<input type="hidden" name="id_usuario" value="${tarefa.id_usuario}">
			<input type="hidden" name="id" value="${tarefa.id}">
			
			<input type="submit" value="Alterar" />
	</form>
	
	<c:import url="rodape.jsp" />
</body>
</html>