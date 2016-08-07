package br.com.mafes.memoria.mvc.logica;

import java.sql.Connection;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import br.com.mafes.memoria.jdbc.dao.UsuarioDAO;
import br.com.mafes.memoria.jdbc.modelo.Usuario;
import br.com.mafes.memoria.mvc.logica.Logica;

public class AlteraUsuarioLogic implements Logica{

	@Override
	public String executa(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		String nome = request.getParameter("nome");
		String login = request.getParameter("login");
		String senha = request.getParameter("senha");
		Long id = Long.parseLong(request.getParameter("id"));

		
		Usuario usuario = new Usuario();
		usuario.setId(id);
		usuario.setNome(nome);
		usuario.setLogin(login);
		usuario.setSenha(senha);
		
		Connection connection = (Connection) request.getAttribute("conexao");
		
		UsuarioDAO dao = new UsuarioDAO(connection);
		dao.altera(usuario);
		
		System.out.println("Alterando usuário...");
		
		return "mvc?logica=ListaUsuariosLogic";
		
		
	}

}
