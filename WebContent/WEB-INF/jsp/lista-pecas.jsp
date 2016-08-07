<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<link rel="stylesheet" type="text/css" href="Tabela.css">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Lista Peças da Tarefa</title>
</head>
<body>
		<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
		<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
		
		<c:import url="cabecalho-logado.jsp" />
		
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
      					<a href="mvc?logica=RemovePecaLogic&id=${peca.id}&id_tarefa=${peca.id_tarefa}">Remover</a>
    				</td>	
    				
    				<td>
      					<a href="mvc?logica=MostraPecaLogic&id=${peca.id}">Alterar</a>
    				</td>		
    					
				</tr>
			
			</c:forEach>
		</table>
		
		<c:import url="rodape.jsp" />
</body>
</html>