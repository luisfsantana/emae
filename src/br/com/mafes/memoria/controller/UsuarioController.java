package br.com.mafes.memoria.controller;

import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;

import br.com.mafes.memoria.jdbc.dao.TarefaDAO;
import br.com.mafes.memoria.jdbc.dao.UsuarioDAO;
import br.com.mafes.memoria.jdbc.modelo.Tarefa;
import br.com.mafes.memoria.jdbc.modelo.Usuario;

@Controller
public class UsuarioController {

	@RequestMapping("novoUsuario")
	public String form(){
		return "usuario/adiciona-usuario";
	}
	
	
	@RequestMapping("adicionaUsuario")
	public String adiciona(@Valid Usuario usuario, BindingResult result) {
		  
		if(result.hasErrors()){
			return "usuario/adiciona-usuario";
		}
		
		UsuarioDAO dao = new UsuarioDAO();
		dao.adiciona(usuario);
		
		return "usuario/adicionado";
		
	}
	
	@RequestMapping("listaUsuarios")
	public String lista(Model model){
		
		UsuarioDAO dao = new UsuarioDAO();
		model.addAttribute("usuarios", dao.getLista());
		
		return "usuario/lista";
	}
	
	@RequestMapping("removeUsuario")
	public String remove(Usuario usuario) {
		  UsuarioDAO dao = new UsuarioDAO();
		  dao.exclui(usuario);
		  return "redirect:listaUsuarios";
	}
	
	@RequestMapping("mostraUsuario")
	public String mostra(Long id, Model model) {
	  UsuarioDAO dao = new UsuarioDAO();
	  model.addAttribute("usuario", dao.getUsuario(id));
	  return "usuario/mostra";
	}
	
	@RequestMapping("alteraUsuario")
	public String altera(Usuario usuario) {
	  UsuarioDAO dao = new UsuarioDAO();
	  dao.altera(usuario);
	  return "redirect:listaUsuarios";
	}
}
