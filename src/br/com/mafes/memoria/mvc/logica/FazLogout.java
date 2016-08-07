package br.com.mafes.memoria.mvc.logica;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class FazLogout implements Logica {

	@Override
	public String executa(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		
		HttpSession session = request.getSession();
		session.invalidate();
		
		
		return "/login.jsp";
		
	}

}
