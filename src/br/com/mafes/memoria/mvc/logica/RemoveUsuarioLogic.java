package br.com.mafes.memoria.mvc.logica;

import java.sql.Connection;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import br.com.mafes.memoria.jdbc.dao.UsuarioDAO;
import br.com.mafes.memoria.jdbc.modelo.Usuario;
import br.com.mafes.memoria.mvc.logica.Logica;

public class RemoveUsuarioLogic implements Logica{

	@Override
	public String executa(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		Long id = Long.parseLong(request.getParameter("id"));
		
		Usuario usuario = new Usuario();
		usuario.setId(id);
		
		Connection connection = (Connection) request.getAttribute("conexao");
		
		UsuarioDAO dao = new UsuarioDAO(connection);
		dao.exclui(usuario);
		
		System.out.println("Excluindo usuário...");
		
		
		return "mvc?logica=ListaUsuariosLogic";
		
	}

}
