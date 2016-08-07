<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>		
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link href="<c:url value="/resources/css/jquery-ui.css" />" rel="stylesheet">
	<script src="<c:url value="/resources/js/jquery.js" />"></script>
	<script src="<c:url value="/resources/js/jquery-ui.js" />"></script>
	<link rel="stylesheet" type="text/css" href="/resources/css/Tabela.css">
	<title>Lista de todas as tarefas</title>
</head>
<body>
	
		<c:import url="/WEB-INF/jsp/cabecalho-logado.jsp" />
		
		 <script type="text/javascript">
		    function finalizaAgora(id) {
		      $.post("finalizaTarefa", {'id' : id}, function() {
		        // selecionando o elemento html através da 
		        // ID e alterando o HTML dele 
		        $("#tarefa_"+id).html("Finalizado");
		      });
		    }
		  </script>
		
		  <a href="novaTarefa">Criar nova tarefa</a> <br/><br/>
		
		<table>
			<tr>
				<th>Prioridade</th>
				<th>Status</th>
				<th>Nome</th>
				<th>Observações</th>
				<th>Data Início</th>
				<th>Data Fim</th>
				<th>Responsável</th>
				<th>Finalizado?</th>
			</tr>
			 
			<!-- percorre contatos montando as linhas da tabela -->
			<c:forEach var="tarefa" items="${tarefas}">
				<tr>
				 	<td><div>${tarefa.prioridade}</div></td><!-- Mudar a cor dependendo da prioridade -->
					<td>${tarefa.status}</td>
				 	<td>${tarefa.nome}</td>
					<td>${tarefa.observacao}</td>
					<td><fmt:formatDate value="${tarefa.datainicio.time}" pattern="dd/MM/yyyy"/></td>
				 	<td><fmt:formatDate value="${tarefa.datafim.time}" pattern="dd/MM/yyyy"/></td>
				 	<td>${tarefa.responsavel}</td>
				 	
				 	<c:if test="${tarefa.finalizado eq false}">
					  <td id="tarefa_${tarefa.id}">
					      <a href="#" onClick="finalizaAgora(${tarefa.id})">
					      Finaliza agora!
					      </a>
					  </td>
			  		</c:if>	
					
					
				 	<td>
      					<a href="removeTarefa?id=${tarefa.id}">Remover</a>
    				</td>	
    				
    				<td>
      					<a href="mostraTarefa?id=${tarefa.id}">Alterar</a>
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
		    				<input type="submit" value="Exibir Lista de Peças" />
    					</form>	
					</td>
				</tr>
			
				</c:forEach>
				
							
				
		</table>
		
		<c:import url="/WEB-INF/jsp/rodape.jsp" />
</body>
</html>