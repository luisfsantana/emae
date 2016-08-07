<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib tagdir="/WEB-INF/tags" prefix="mafes" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<link href="<c:url value="/resources/css/jquery-ui.css" />" rel="stylesheet">
		<script src="<c:url value="/resources/js/jquery.js" />"></script>
	    <script src="<c:url value="/resources/js/jquery-ui.js" />"></script>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Adiciona Tarefa</title>
	</head>
<body>

	
    <c:import url="/WEB-INF/jsp/cabecalho.jsp" />
    
	<form:errors path="*" cssStyle="color:red"/>
			
	
	<div style="position: absolute; left: 100px;" >		
	<h2>Insira os dados da Tarefa</h2>
	
	<form action="adicionaTarefa" method="post">
			Prioridade:&nbsp;&nbsp;
			<select name="prioridade">
			  <option value="0" style="background-color: red">Urgente</option>
			  <option value="1" style="background-color: orange">Alta</option>
			  <option value="2" style="background-color: yellow">Média</option>
			  <option value="3" style="background-color: blue">Baixa</option>
			</select>
			<br /><br />
			Status:&nbsp;&nbsp; 
			<select name="status">
			  <option value="Em Processo">Em Processo</option>
			  <option value="Tarefa Parada">Tarefa Parada</option>
			</select>
			<br /><br />
			
			Título da Tarefa: <input type="text" name="nome" />&nbsp;&nbsp;
			<form:errors path="tarefa.nome" cssStyle="color:red"/><br /><br />
	
			
			Observações: <br /><textarea name="observacao"  rows="5" cols="100"></textarea>&nbsp;&nbsp; 
			
			<form:errors path="tarefa.observacao" cssStyle="color:red"/>
	
			<br />
			Data Início: <mafes:campoData id="datainicio" name="datainicio"/>&nbsp;&nbsp;
			<form:errors path="tarefa.datainicio" cssStyle="color:red"/><br />
			<br />
			Data Fim: <mafes:campoData id="datafim" name="datafim"/>&nbsp;&nbsp;
			<form:errors path="tarefa.datafim" cssStyle="color:red"/><br />
			<br />
			<!-- TODO Listar os usuarios do sistema -->
		 	Responsável: <input type="text" name="responsavel" /><br /><br /> 
		 	
		 	
		 	Ordem da Tarefa em relação as outras: <input type="text" name="ordem" /><br /><br />
			<input type="hidden" name="id_usuario" value="1"><!--### TODO: Passar objeto usuário -->
			Finalizado: <input type="checkbox"  name="finalizado"> <br /><br />
			<input type="hidden" name="_finalizado" value="on"/>
			
			<input type="submit" value="Adicionar" align="middle"/>
	</form>
	</div>
	<br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
	
	<c:import url="/WEB-INF/jsp/rodape.jsp" />
	
</body>
</html>