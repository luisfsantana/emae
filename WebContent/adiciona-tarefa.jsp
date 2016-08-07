<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<link href="css/jquery-ui.css" rel="stylesheet">
	    <script src="js/jquery.js"></script>
	    <script src="js/jquery-ui.js"></script>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Adiciona Tarefa</title>
	</head>
<body>

	<%@taglib tagdir="/WEB-INF/tags" prefix="mafes" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	
    <c:import url="/WEB-INF/jsp/cabecalho.jsp" />
	
	<form action="mvc">
			<input type="hidden" name="logica" value="AdicionaTarefaLogic">
			Prioridade: <input type="text" name="prioridade" /><br /><br />
			Status: <input type="text" name="status" /><br /><br />
			Nome: <input type="text" name="nome" /><br /><br />
			Observações: <input type="text" name="observacao" /><br /><br />
			Data Inicio: <mafes:campoData id="datainicio" /><br /><br />
			Data Fim: <mafes:campoData id="datafim" /><br /><br />
		 	Responsável: <input type="text" name="responsavel" /><br /><br />
			<input type="hidden" name="id_usuario" value="${id_usuario}"><br /><br />
			<input type="submit" value="Gravar" />
	</form>
	<c:import url="/WEB-INF/jsp/rodape.jsp" />
	
</body>
</html>