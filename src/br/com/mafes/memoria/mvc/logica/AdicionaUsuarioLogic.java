package br.com.mafes.memoria.mvc.logica;

import java.sql.Connection;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import br.com.mafes.memoria.jdbc.dao.UsuarioDAO;
import br.com.mafes.memoria.jdbc.modelo.Usuario;
import br.com.mafes.memoria.mvc.logica.Logica;

public class AdicionaUsuarioLogic implements Logica{

	@Override
	public String executa(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
				
		String nome = request.getParameter("nome");
		String login = request.getParameter("login");
		String senha = request.getParameter("senha");
		
		
		System.out.println("nome= "+nome);
		System.out.println("login= "+login);
		System.out.println("senha= "+senha);
		
		Usuario usuario = new Usuario();
		usuario.setNome(nome);
		usuario.setLogin(login);
		usuario.setSenha(senha);
		
		Connection connection = (Connection) request.getAttribute("conexao");
		
		UsuarioDAO dao = new UsuarioDAO(connection);
		dao.adiciona(usuario);
		
		
		return "/WEB-INF/jsp/usuario-adicionado.jsp";
	}

}
