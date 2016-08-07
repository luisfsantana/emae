package br.com.mafes.memoria.mvc.logica;

import java.sql.Connection;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import br.com.mafes.memoria.jdbc.dao.TarefaDAO;
import br.com.mafes.memoria.jdbc.modelo.Tarefa;

public class ExibiListaTarefasUsuarioLogic implements Logica {

	@Override
	public String executa(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		
		Long id_usuario = Long.parseLong(request.getParameter("id_usuario")); 
		
		Connection connection = (Connection) request.getAttribute("conexao");
		
		
		TarefaDAO dao = new TarefaDAO(connection);
		List<Tarefa> tarefas = dao.getListTarefasIdUsuario(id_usuario);
		
		request.setAttribute("tarefas", tarefas);
		
		return "/WEB-INF/jsp/lista-tarefas.jsp";
		
		
	}

}
