package br.com.mafes.memoria.mvc.logica;

import java.io.PrintWriter;
import java.sql.Connection;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import br.com.mafes.memoria.jdbc.dao.PecaDAO;
import br.com.mafes.memoria.jdbc.modelo.Peca;

public class AdicionaPecaLogic implements Logica {

	@Override
	public String executa(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		PrintWriter out = response.getWriter();
		
		String quantidade = request.getParameter("quantidade");
		String nome = request.getParameter("nome");
		String estado = request.getParameter("estado");
		String observacao = request.getParameter("observacao");
		String dataStr = request.getParameter("data");
		String id_tarefaStr = request.getParameter("id_tarefa");
		String status = request.getParameter("status");
		
		System.out.println("nome= "+nome);
		System.out.println("data= "+ dataStr);
		System.out.println("Id_Usuario= "+ id_tarefaStr);
		
		
		Peca peca = new Peca();
		Integer quantidadeNumber = Integer.parseInt(quantidade);
		peca.setQuantidade(quantidadeNumber);
		peca.setNome(nome);
		peca.setEstado(estado);
		peca.setObservacao(observacao);
		peca.setStatus(status);

		Calendar dataInicio = null;
		
		try{
			Date data = new SimpleDateFormat("dd/MM/yyyy").parse(dataStr);
			dataInicio = Calendar.getInstance();
			dataInicio.setTime(data);
			
		}catch(ParseException e){
			out.println("Erro na conversão da Data de Inicio");	
			return "0";
		}
		
		peca.setData(dataInicio);
		
		Long id_tarefa = Long.parseLong(id_tarefaStr);
		
		peca.setId_tarefa(id_tarefa);
		
		Connection connection = (Connection) request.getAttribute("conexao");
		
		PecaDAO dao = new PecaDAO(connection);
		dao.adiciona(peca);
		
		request.setAttribute("id_tarefa", id_tarefa);
		
		return "/WEB-INF/jsp/peca-adicionada.jsp";
		
		
	}

}
