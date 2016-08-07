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
	<title>Adiciona Peça</title>
</head>
<body>
	<%@taglib tagdir="/WEB-INF/tags" prefix="mafes" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	
    <c:import url="/WEB-INF/jsp/cabecalho.jsp" />
    
	<div style="position: absolute; left: 100px;">
	<h2>Adicionar Peça</h2>
	<form action="adicionaPeca" method="post">
			Quantidade:&nbsp;&nbsp; <input type="number" name="quantidade" min="1" max="100">
			<form:errors path="peca.quantidade" cssStyle="color:red"/>
	
			<br /><br />
			Nome:&nbsp;&nbsp; <input type="text" name="nome" />
			<form:errors path="peca.nome" cssStyle="color:red"/>
	
			<br /><br />
			Estado:&nbsp;&nbsp; <select name="estado">
			  <option value="Atrasada">Atrasada</option>
			  <option value="Em Processo" selected>No Prazo</option>
			  <option value="Concluida">Concluída</option>
			</select>
			
			
			<br /><br />
			Observação: <br /> <textarea name="observacao" rows="5" cols="100"></textarea>
			<form:errors path="peca.observacao" cssStyle="color:red"/>
	
			
			<br /><br />
			Data: <mafes:campoData name="data" id="data" />
			<form:errors path="peca.data" cssStyle="color:red"/>
			
			<br /><br />
		 	Status: &nbsp;&nbsp; <select name="status">
			  <option value="Estagio Inicial">Estágio Inicial</option>
			  <option value="Parcialmente Concluída">Parcialmente Concluída</option>
			  <option value="Completa">Completa</option>
			</select>
		 	<br /><br />
		 	
			<input type="hidden" name="id_tarefa" value="2">
			<input type="submit" value="Adicionar Peça" />
	</form>
	</div>
	<br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
	<c:import url="/WEB-INF/jsp/rodape.jsp" />
</body>
</html>