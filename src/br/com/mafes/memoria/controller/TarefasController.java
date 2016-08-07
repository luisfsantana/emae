package br.com.mafes.memoria.controller;

import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;

import br.com.mafes.memoria.jdbc.dao.TarefaDAO;
import br.com.mafes.memoria.jdbc.modelo.Tarefa;

@Controller
public class TarefasController {
	
	@RequestMapping("novaTarefa")
	public String form(){
		return "tarefa/adiciona-tarefa";
	}
	
	
	@RequestMapping("adicionaTarefa")
	public String adiciona(@Valid Tarefa tarefa, BindingResult result) {
		  
		if(result.hasErrors()){
			return "tarefa/adiciona-tarefa";
		}
		
		TarefaDAO dao = new TarefaDAO();
		dao.adiciona(tarefa);
		
		return "tarefa/adicionada";
		
	}

	@RequestMapping("listaTarefas")
	public String lista(Model model){
		TarefaDAO dao = new TarefaDAO();
		model.addAttribute("tarefas", dao.getLista());
		
		return "tarefa/lista";
	}
	
	@RequestMapping("removeTarefa")
	public String remove(Tarefa tarefa) {
	  TarefaDAO dao = new TarefaDAO();
	  dao.exclui(tarefa);
	  return "redirect:listaTarefas";
	}
	
	@RequestMapping("mostraTarefa")
	public String mostra(Long id, Model model) {
	  TarefaDAO dao = new TarefaDAO();
	  model.addAttribute("tarefa", dao.getTarefa(id));
	  return "tarefa/mostra";
	}
	
	@RequestMapping("alteraTarefa")
	public String altera(Tarefa tarefa) {
	  TarefaDAO dao = new TarefaDAO();
	  dao.altera(tarefa);
	  return "redirect:listaTarefas";
	}
	
	@RequestMapping("finalizaTarefa")
	public void finaliza(Long id, HttpServletResponse response) {
	  TarefaDAO dao = new TarefaDAO();
	  dao.finaliza(id);
	  response.setStatus(200);
	}
}
