package br.com.mafes.memoria.mvc.logica;

import java.sql.Connection;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import br.com.mafes.memoria.jdbc.dao.UsuarioDAO;
import br.com.mafes.memoria.jdbc.modelo.Usuario;
import br.com.mafes.memoria.mvc.logica.Logica;

public class ListaUsuariosLogic implements Logica{

	@Override
	public String executa(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		Connection connection = (Connection) request.getAttribute("conexao");
		
		UsuarioDAO dao = new UsuarioDAO(connection);
		
		List<Usuario> usuarios = dao.getLista();
		
		request.setAttribute("usuarios", usuarios);
		
		return "/WEB-INF/jsp/lista-usuarios.jsp";
		
		
	}

}
