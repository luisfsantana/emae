package br.com.mafes.memoria.mvc.logica;

import java.sql.Connection;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import br.com.mafes.memoria.jdbc.dao.UsuarioDAO;
import br.com.mafes.memoria.jdbc.modelo.Usuario;

public class FazLoginLogic implements Logica {

	@Override
	public String executa(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
	        
		String login = request.getParameter("login");
		String senha = request.getParameter("senha");
		
		
		Connection connection = (Connection) request.getAttribute("conexao");
		
		Usuario usuario = null;
		UsuarioDAO dao = new UsuarioDAO(connection);
		usuario = dao.getUsuarioLoginSenha(login, senha);
		
		if(usuario != null){
			request.setAttribute("usuario", usuario);
			HttpSession session = request.getSession();
			session.setAttribute("usuario", usuario);
		
			return "/WEB-INF/jsp/sucesso-login.jsp";
		}else{
			return "/WEB-INF/jsp/erro-login.jsp";
		}
	}

}
