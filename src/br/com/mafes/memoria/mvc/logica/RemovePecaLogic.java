package br.com.mafes.memoria.mvc.logica;

import java.sql.Connection;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import br.com.mafes.memoria.jdbc.dao.PecaDAO;
import br.com.mafes.memoria.jdbc.modelo.Peca;

public class RemovePecaLogic implements Logica {

	@Override
	public String executa(HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		Long id = Long.parseLong(request.getParameter("id"));
		Long id_tarefa = Long.parseLong(request.getParameter("id_tarefa"));
		
		Peca peca = new Peca();
		peca.setId(id);
		
		Connection connection = (Connection) request.getAttribute("conexao");
		
		
		PecaDAO dao = new PecaDAO(connection);
		dao.exclui(peca);
		
		System.out.println("Excluindo peca...");
		
		request.setAttribute("id_tarefa", id_tarefa);
		
		return "mvc?logica=ExibiListaPecasTarefaLogic";
		
	}

}
