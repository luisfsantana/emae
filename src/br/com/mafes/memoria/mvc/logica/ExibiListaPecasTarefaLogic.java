package br.com.mafes.memoria.mvc.logica;

import java.sql.Connection;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import br.com.mafes.memoria.jdbc.dao.PecaDAO;
import br.com.mafes.memoria.jdbc.modelo.Peca;

public class ExibiListaPecasTarefaLogic implements Logica {

	@Override
	public String executa(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		
		String id_tarefaStr = request.getParameter("id_tarefa");
		Long id_tarefa = Long.parseLong(id_tarefaStr); 
		
		Connection connection = (Connection) request.getAttribute("conexao");
		
		
		PecaDAO dao = new PecaDAO(connection);
		List<Peca> pecas = dao.getListPecasIdTarefa(id_tarefa);
		
		request.setAttribute("pecas", pecas);
		
		return "/WEB-INF/jsp/lista-pecas.jsp";
		
	}

}
