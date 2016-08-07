package br.com.mafes.memoria.mvc.logica;

import java.sql.Connection;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import br.com.mafes.memoria.jdbc.dao.TarefaDAO;
import br.com.mafes.memoria.jdbc.modelo.Tarefa;

public class ListaTarefasLogic implements Logica {

	@Override
	public String executa(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		Connection connection = (Connection) request.getAttribute("conexao");
		
		TarefaDAO dao = new TarefaDAO(connection);
		
		List<Tarefa> tarefas = dao.getLista();
		
		request.setAttribute("tarefas", tarefas);
		
		return "/WEB-INF/jsp/lista-tarefas.jsp";
		
	}

}
