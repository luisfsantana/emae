<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib tagdir="/WEB-INF/tags" prefix="mafes" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<link href="<c:url value="/resources/css/jquery-ui.css" />" rel="stylesheet">
	<script src="<c:url value="/resources/js/jquery.js" />"></script>
	<script src="<c:url value="/resources/js/jquery-ui.js" />"></script>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Mostrar Dados da Tarefa</title>
</head>
<body>
		
	<c:import url="/WEB-INF/jsp/cabecalho-logado.jsp" />
	<div style="position: absolute; left: 100px;">
	  <h3>Alterar tarefa - ${tarefa.id} - ${tarefa.nome}</h3>
		
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
		 	<td><fmt:formatDate value="${tarefa.datainicio.time}" pattern="dd/MM/yyyy"/></td>
			<td><fmt:formatDate value="${tarefa.datafim.time}" pattern="dd/MM/yyyy"/></td>
		 	<td>${tarefa.responsavel}</td>
		 	
		</tr>
	</table>
	<br/><br/><br/>
	<form action="alteraTarefa" method="post">
			 Prioridade: <select name="prioridade" value="${tarefa.prioridade}">
			  <option value="1" selected>1</option>
			  <option value="2">2</option>
			  <option value="3">3</option>
			</select>
			<br /><br/>
			Status: <input type="text" name="status" value="${tarefa.status}" /><br /><br/>
			Nome: <input type="text" name="nome" value="${tarefa.nome}" /><br/><br/>
			Observações:<br/> <textarea name="observacao" cols="100" rows="5">${tarefa.observacao}</textarea><br /><br/>
			
			<fmt:formatDate value="${tarefa.datainicio.time}" pattern="dd/MM/yyyy" var="theFormattedDate" /> 
			Data Inicio: <mafes:campoData id="datainicio" name="datainicio" value="${theFormattedDate}"/><br /><br />
			
			<fmt:formatDate value="${tarefa.datafim.time}" pattern="dd/MM/yyyy" var="theFormattedDate1" />
			Data Fim: <mafes:campoData id="datafim" name="datafim" value="${theFormattedDate1}"/><br /><br />
			Ordem da Tarefa em relação as outras: <input type="text" name="ordem" value="${tarefa.ordem}"/><br /><br />
		
			Responsável: <input type="text" name="responsavel" value="${tarefa.responsavel}" /><br/><br/>
			<input type="hidden" name="id_usuario" value="${tarefa.id_usuario}">
			<input type="hidden" name="id" value="${tarefa.id}">
			
			<input type="submit" value="Alterar" />
	</form>
	</div>
	
	<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
	<c:import url="/WEB-INF/jsp/rodape.jsp" />
</body>
</html>