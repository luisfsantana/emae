package br.com.mafes.memoria.mvc.logica;

import java.sql.Connection;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import br.com.mafes.memoria.jdbc.dao.UsuarioDAO;
import br.com.mafes.memoria.jdbc.modelo.Usuario;
import br.com.mafes.memoria.mvc.logica.Logica;

public class MostraUsuarioLogic implements Logica {

	@Override
	public String executa(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		Long id = Long.parseLong(request.getParameter("id"));
		
		System.out.println(id);
		
		Connection connection = (Connection) request.getAttribute("conexao");
		
		UsuarioDAO dao = new UsuarioDAO(connection);
		Usuario usuarioApresentacao = dao.getUsuario(id);
		
		request.setAttribute("usuario", usuarioApresentacao);

		System.out.println("Mostrando usuario...");

		return "/WEB-INF/jsp/mostra-usuario.jsp";
		
	}

}
