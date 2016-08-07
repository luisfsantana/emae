package br.com.mafes.memoria.mvc.logica;



import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import br.com.mafes.memoria.jdbc.modelo.Peca;

public class AbreAdicionaPecaLogic implements Logica {

	@Override
	public String executa(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		Long id_tarefa = Long.parseLong(request.getParameter("id"));
		
		Peca pecaApresentacao = new Peca();
		pecaApresentacao.setId_tarefa(id_tarefa);
		
		request.setAttribute("peca", pecaApresentacao);

		System.out.println("abre aprentação da peca...");

	
		return "/adiciona-peca.jsp";
	}

}
