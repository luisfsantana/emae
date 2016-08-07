<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<link href="css/jquery-ui.css" rel="stylesheet">
	<script src="js/jquery.js"></script>
	<script src="js/jquery-ui.js"></script>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Adiciona Peça</title>
</head>
<body>
	<%@taglib tagdir="/WEB-INF/tags" prefix="mafes" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	
    <c:import url="/WEB-INF/jsp/cabecalho.jsp" />
	
	<form action="mvc">
			<input type="hidden" name="logica" value="AdicionaPecaLogic">
			Quantidade: <input type="text" name="quantidade" /><br /><br />
			Nome: <input type="text" name="nome" /><br /><br />
			Estado: <input type="text" name="estado" /><br /><br />
			Observação: <input type="text" name="observacao" /><br /><br />
			Data: <mafes:campoData id="data" /><br /><br />
		 	Status: <input type="text" name="status" /><br /><br />
		 	
			<input type="hidden" name="id_tarefa" value="${peca.id_tarefa}">
			<input type="submit" value="Gravar" /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
	</form>
	<c:import url="/WEB-INF/jsp/rodape.jsp" />
</body>
</html>