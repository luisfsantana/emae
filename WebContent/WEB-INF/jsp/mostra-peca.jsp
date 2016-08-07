<%@page import="java.net.ResponseCache"%>
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
		<title>Mostra Peça</title>
	</head>
<body>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
	<%@taglib tagdir="/WEB-INF/tags" prefix="mafes" %>
    	
	<c:import url="cabecalho-logado.jsp" />
	
		
	<table>
		<tr>
				<th>Quantidade</th>
				<th>Nome</th>
				<th>Estado</th>
				<th>Observações</th>
				<th>data</th>
				<th>Status</th>
				
		</tr>

		<tr>
		 	<td>${peca.quantidade}</td>
		 	<td>${peca.nome}</td>
		 	<td>${peca.estado}</td>
		 	<td>${peca.observacao}</td>
		 	<td><fmt:formatDate value="${peca.data.time}" pattern="dd/MM/yyyy"/></td>
		 	<td>${peca.status}</td>
		 	
		</tr>
	</table>
	
	<form action="mvc">
			<input type="hidden" name="logica" value="AlteraPecaLogic">
			Quantidade: <input type="text" name="quantidade" value="${peca.quantidade}" size="2"/><br />
			Nome: <input type="text" name="nome" value="${peca.nome}" size="75"/>
			Estado: <input type="text" name="estado" value="${peca.estado}" size="35"/><br />
			Observações: <input type="text" name="observacao" value="${peca.observacao}" size="80"/><br />
			
			<fmt:formatDate value="${peca.data.time}" pattern="dd/MM/yyyy" var="theFormattedDate" /> <br />
			Data: <mafes:campoData id="data" value="${theFormattedDate}"/><br /><br />
			
			
			Status: <input type="text" name="status" value="${peca.status}" size="35"/><br />
			
			<input type="hidden" name="id_tarefa" value="${peca.id_tarefa}">
			<input type="hidden" name="id" value="${peca.id}">
			
			<input type="submit" value="Alterar" />
	</form>
	
	<c:import url="rodape.jsp" />	
</body>
</html>