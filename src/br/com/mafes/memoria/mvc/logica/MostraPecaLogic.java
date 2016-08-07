package br.com.mafes.memoria.mvc.logica;

import java.sql.Connection;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import br.com.mafes.memoria.jdbc.dao.PecaDAO;
import br.com.mafes.memoria.jdbc.modelo.Peca;

public class MostraPecaLogic implements Logica {

	@Override
	public String executa(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		Long id = Long.parseLong(request.getParameter("id"));
		
		System.out.println(id);
		
		Connection connection = (Connection) request.getAttribute("conexao");
		
		PecaDAO dao = new PecaDAO(connection);
		Peca pecaApresentacao = dao.getPeca(id);
		
		request.setAttribute("peca", pecaApresentacao);

		System.out.println("Mostrando peca...");

		return "/WEB-INF/jsp/mostra-peca.jsp";
		
	}

}
