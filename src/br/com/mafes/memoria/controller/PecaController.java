package br.com.mafes.memoria.controller;

import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;

import br.com.mafes.memoria.jdbc.dao.PecaDAO;
import br.com.mafes.memoria.jdbc.modelo.Peca;

@Controller
public class PecaController {
	
	@RequestMapping("novaPeca")
	public String form(){
		return "peca/adiciona-peca";
	}
	
	
	@RequestMapping("adicionaPeca")
	public String adiciona(@Valid Peca peca, BindingResult result) {
		  
		if(result.hasErrors()){
			return "peca/adiciona-peca";
		}
		
		PecaDAO dao = new PecaDAO();
		dao.adiciona(peca);
		
		return "peca/adicionada";
		
	}
	
	@RequestMapping("listaPecas")
	public String lista(Model model){
		PecaDAO dao = new PecaDAO();
		model.addAttribute("pecas", dao.getLista());
		
		return "peca/lista";
	}
	
	@RequestMapping("removePeca")
	public String remove(Peca peca) {
	  PecaDAO dao = new PecaDAO();
	  dao.exclui(peca);
	  return "redirect:listaPecas";
	}
	
	@RequestMapping("mostraPeca")
	public String mostra(Long id, Model model) {
	  PecaDAO dao = new PecaDAO();
	  model.addAttribute("peca", dao.getPeca(id));
	  return "peca/mostra";
	}
	
	@RequestMapping("alteraPeca")
	public String altera(Peca peca) {
	  PecaDAO dao = new PecaDAO();
	  dao.altera(peca);
	  return "redirect:listaPecas";
	}
	
}
