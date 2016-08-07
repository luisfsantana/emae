package br.com.mafes.memoria.mvc.logica;



import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import br.com.mafes.memoria.jdbc.dao.TarefaDAO;
import br.com.mafes.memoria.jdbc.modelo.Tarefa;

public class RemoveTarefaLogic implements Logica {

	@Override
	public String executa(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		Long id = Long.parseLong(request.getParameter("id"));
		
		Tarefa tarefa = new Tarefa();
		tarefa.setId(id);
		
	
		TarefaDAO dao = new TarefaDAO();
		dao.exclui(tarefa);
		
		System.out.println("Excluindo tarefa...");
		
		
		return "mvc?logica=ExibiListaTarefasUsuarioLogic";
		
	}

}
