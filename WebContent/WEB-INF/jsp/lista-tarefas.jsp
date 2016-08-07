<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" type="text/css" href="Tabela.css">
	<title>Lista Tarefas</title>
</head>
<body>
		<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
		<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
		
		<c:import url="cabecalho-logado.jsp" />
		
		<table>
			<tr>
				<th>Prioridade</th>
				<th>Status</th>
				<th>Nome</th>
				<th>Observações</th>
				<th>Data Início</th>
				<th>Data Fim</th>
				<th>Responsável</th>
			</tr>
			 
			<!-- percorre contatos montando as linhas da tabela -->
			<c:forEach var="tarefa" items="${tarefas}">
				<tr>
				 	<td>${tarefa.prioridade}</td>
					<td>${tarefa.status}</td>
				 	<td>${tarefa.nome}</td>
					<td>${tarefa.observacao}</td>
					<td><fmt:formatDate value="${tarefa.dataInicio.time}" pattern="dd/MM/yyyy"/></td>
				 	<td><fmt:formatDate value="${tarefa.dataFim.time}" pattern="dd/MM/yyyy"/></td>
				 	<td>${tarefa.responsavel}</td>
				
				 	<td>
      					<a href="mvc?logica=RemoveTarefaLogic&id=${tarefa.id}">Remover</a>
    				</td>	
    				
    				<td>
      					<a href="mvc?logica=MostraTarefaLogic&id=${tarefa.id}">Alterar</a>
    				</td>	
    				<td>
    					<form action="mvc">
							<input type="hidden" name="logica" value="AbreAdicionaPecaLogic">
							<input type="hidden" name="id" value="${tarefa.id}">
		    				<input type="submit" value="Adicionar Peca" />
    					</form>	
					</td>
					<td>
    					<form action="mvc">
							<input type="hidden" name="logica" value="ExibiListaPecasTarefaLogic">
							<input type="hidden" name="id_tarefa" value="${tarefa.id}">
		    				<input type="submit" value="Exibir Lista de Peças da Tarefa" />
    					</form>	
					</td>
				</tr>
			
			</c:forEach>
		</table>
		
		<c:import url="rodape.jsp" />
</body>
</html>