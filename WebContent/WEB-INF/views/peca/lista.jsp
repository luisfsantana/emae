<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" type="text/css" href="/resources/css/Tabela.css">
	<title>Lista as Peças da Tarefa</title>
</head>
<body>
		<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
		<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
		
		<c:import url="/WEB-INF/jsp/cabecalho-logado.jsp" />
		
		<table>
			<tr>
				<th>Quantidade</th>
				<th>Nome</th>
				<th>Estado</th>
				<th>Observações</th>
				<th>Data Início</th>
				<th>Status</th>
				
			</tr>
			 
			<!-- percorre contatos montando as linhas da tabela -->
			<c:forEach var="peca" items="${pecas}">
				<tr>
				 	<td>${peca.quantidade}</td>
				 	<td>${peca.nome}</td>
					<td>${peca.estado}</td>
					<td>${peca.observacao}</td>
					<td><fmt:formatDate value="${peca.data.time}" pattern="dd/MM/yyyy"/></td>
					<td>${peca.status}</td>
				
				 	<td>
      					<a href="removePeca?id=${peca.id}">Remover</a>
    				</td>	
    				
    				<td>
      					<a href="mostraPeca?id=${peca.id}">Alterar</a>
    				</td>		
    					
				</tr>
			
			</c:forEach>
		</table>
		
		<c:import url="/WEB-INF/jsp/rodape.jsp" />
</body>
</html>