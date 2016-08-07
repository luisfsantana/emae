package br.com.mafes.memoria.mvc.logica;

import java.sql.Connection;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import br.com.mafes.memoria.jdbc.dao.TarefaDAO;
import br.com.mafes.memoria.jdbc.modelo.Tarefa;

public class MostraTarefaLogic implements Logica {

	@Override
	public String executa(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		Long id = Long.parseLong(request.getParameter("id"));
		
		System.out.println(id);
		
		Connection connection = (Connection) request.getAttribute("conexao");
		
		TarefaDAO dao = new TarefaDAO(connection);
		Tarefa tarefaApresentacao = dao.getTarefa(id);
		
		request.setAttribute("tarefa", tarefaApresentacao);

		System.out.println("Mostrando tarefa...");

		return "/WEB-INF/jsp/mostra-tarefa.jsp";
		
		
	}

}
