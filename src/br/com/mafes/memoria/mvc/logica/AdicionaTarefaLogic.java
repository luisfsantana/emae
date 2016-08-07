package br.com.mafes.memoria.mvc.logica;

import java.io.PrintWriter;
import java.sql.Connection;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import br.com.mafes.memoria.jdbc.dao.TarefaDAO;
import br.com.mafes.memoria.jdbc.modelo.Tarefa;

public class AdicionaTarefaLogic implements Logica {

	@Override
	public String executa(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		PrintWriter out = response.getWriter();
		
		String prioridade = request.getParameter("prioridade");
		String status = request.getParameter("status");
		String nome = request.getParameter("nome");
		String observacao = request.getParameter("observacao");
		String dataInicioEmTexto = request.getParameter("datainicio");
		String dataFimEmTexto = request.getParameter("datafim");
		String responsavel = request.getParameter("responsavel");
		String id_usuarioStr = request.getParameter("id_usuario");
		
		System.out.println("nome= "+nome);
		System.out.println("responsavel= "+responsavel);
		System.out.println("dataincio= "+ dataInicioEmTexto);
		System.out.println("Id_Usuario= "+ id_usuarioStr);
		
		
		Tarefa tarefa = new Tarefa();
		Integer prioridadeNumber = Integer.parseInt(prioridade);
		tarefa.setPrioridade(prioridadeNumber);
		tarefa.setStatus(status);
		tarefa.setNome(nome);
		tarefa.setObservacao(observacao);
		
		Calendar dataInicio = null;
		
		try{
			Date data = new SimpleDateFormat("dd/MM/yyyy").parse(dataInicioEmTexto);
			dataInicio = Calendar.getInstance();
			dataInicio.setTime(data);
			
		}catch(ParseException e){
			out.println("Erro na conversão da Data de Inicio");	
			return "0";
		}
		
		Calendar dataFim = null;
		
		try{
			Date data = new SimpleDateFormat("dd/MM/yyyy").parse(dataFimEmTexto);
			dataFim = Calendar.getInstance();
			dataFim.setTime(data);
			
		}catch(ParseException e){
			out.println("Erro na conversão da Data de Fim");	
			return "0";
		}
		tarefa.setDataInicio(dataInicio);
		tarefa.setDataFim(dataFim);
		tarefa.setResponsavel(responsavel);
		
		Long id_usuario = Long.parseLong(id_usuarioStr);
		
		tarefa.setId_usuario(id_usuario);
		
		tarefa.setOrdem(id_usuario);

		Connection connection = (Connection) request.getAttribute("conexao");
		
		TarefaDAO dao = new TarefaDAO(connection);
		dao.adiciona(tarefa);
		
		
		return "/WEB-INF/jsp/tarefa-adicionada.jsp";
	}

}
