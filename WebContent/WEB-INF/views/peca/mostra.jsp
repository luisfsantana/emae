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
	<title>Mostra detalhes da Peça</title>
</head>
<body>
	  	
	<c:import url="/WEB-INF/jsp/cabecalho-logado.jsp" />
	
	<div style="position: absolute; left: 100px;">	
	  <h3>Alterar dados da peca - ${peca.id} - ${peca.nome}</h3>
	
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
	<br /><br /><br />
	<form action="alteraPeca" method="post">
			Quantidade: <input type="text" name="quantidade" value="${peca.quantidade}" size="2"/><br /><br />
			Nome: <input type="text" name="nome" value="${peca.nome}" size="75"/><br /><br />
			Estado: <input type="text" name="estado" value="${peca.estado}" size="35"/><br /><br />
			Observações:<br/> <textarea name="observacao" rows="5" cols="100">${peca.observacao}</textarea><br /><br />
			
			<fmt:formatDate value="${peca.data.time}" pattern="dd/MM/yyyy" var="theFormattedDate" /> <br />
			Data: <mafes:campoData name="data" id="data" value="${theFormattedDate}"/><br /><br />
			
			
			Status: <input type="text" name="status" value="${peca.status}" size="35"/><br /><br />
			
			<input type="hidden" name="id_tarefa" value="${peca.id_tarefa}">
			<input type="hidden" name="id" value="${peca.id}">
			
			<input type="submit" value="Alterar" />
	</form>
	</div>
	<br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
	<c:import url="/WEB-INF/jsp/rodape.jsp" />	
</body>
</html>