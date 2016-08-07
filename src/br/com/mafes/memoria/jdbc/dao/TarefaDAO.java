package br.com.mafes.memoria.jdbc.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import br.com.mafes.memoria.jdbc.controller.ConnectionFactory;
import br.com.mafes.memoria.jdbc.modelo.Tarefa;

public class TarefaDAO {

	private Connection connection;
	
	public TarefaDAO(){
		this.connection = new ConnectionFactory().getConnection();
	}
	
	public void adiciona(Tarefa tarefa) {
		String sql = "INSERT INTO tarefas " +
				"(prioridade, status, nome, observacao, datainicio, datafim, responsavel, id_usuario, ordem, finalizado) " +
				"VALUES(?,?,?,?,?,?,?,?,?,?)";
		
		try{
			PreparedStatement stmt = connection.prepareStatement(sql);
			
			stmt.setLong(1, tarefa.getPrioridade());
			stmt.setString(2, tarefa.getStatus());
			stmt.setString(3, tarefa.getNome());
			stmt.setString(4, tarefa.getObservacao());
			
			stmt.setDate(5, new java.sql.Date(tarefa.getDatainicio().getTimeInMillis()));
			stmt.setDate(6, new java.sql.Date(tarefa.getDatafim().getTimeInMillis()));
			
			stmt.setString(7, tarefa.getResponsavel());
			stmt.setLong(8, tarefa.getId_usuario());
			stmt.setLong(9, tarefa.getOrdem());
			stmt.setBoolean(10, tarefa.getFinalizado());
			
			stmt.execute();
			stmt.close();
			
		}catch(SQLException e){
			throw new RuntimeException(e);
		}
		
		
	}

	public void altera(Tarefa tarefa){
		String sql = "update tarefas set prioridade=?, status=?, nome=?, observacao=?, datainicio=?, datafim=?, responsavel=?, id_usuario=?, ordem=?, finalizado=? where id=?";
				
		try{
			PreparedStatement stmt = connection.prepareStatement(sql);
					
			stmt.setLong(1, tarefa.getPrioridade());
			stmt.setString(2, tarefa.getStatus());
			stmt.setString(3, tarefa.getNome());
			stmt.setString(4, tarefa.getObservacao());
			stmt.setDate(5, new java.sql.Date(tarefa.getDatainicio().getTimeInMillis()));
			stmt.setDate(6, new java.sql.Date(tarefa.getDatafim().getTimeInMillis()));
			stmt.setString(7, tarefa.getResponsavel());
			stmt.setLong(8, tarefa.getId_usuario());
			stmt.setLong(9, tarefa.getOrdem());
			stmt.setLong(10, tarefa.getId());
			stmt.setBoolean(11, tarefa.getFinalizado());
			
			stmt.execute();
			stmt.close();
		}catch(SQLException e){
			throw new RuntimeException(e);
		}
	}
	
	public void exclui(Tarefa tarefa){
		try{
			PreparedStatement stmt = connection.prepareStatement("delete from tarefas where id=?");
			stmt.setLong(1, tarefa.getId());
			
			stmt.execute();
			stmt.close();
		}catch(SQLException e){
			throw new RuntimeException(e);
		}	
	}
	
	public List<Tarefa> getLista(){
		
		try{
			List<Tarefa> tarefas = new ArrayList<Tarefa>();
			PreparedStatement stmt = this.connection.prepareStatement("SELECT * FROM tarefas");  
			ResultSet rs = stmt.executeQuery();
			
			while(rs.next()){
				Tarefa tarefa = new Tarefa();
				tarefa.setId(rs.getLong("id"));
				tarefa.setNome(rs.getString("nome"));
				tarefa.setPrioridade(rs.getInt("prioridade"));
				tarefa.setStatus(rs.getString("status"));
				tarefa.setObservacao(rs.getString("observacao"));
				
				Calendar data = Calendar.getInstance();
				data.setTime(rs.getDate("datainicio"));
				tarefa.setDatainicio(data);
				
				Calendar dataFim = Calendar.getInstance();
				
				dataFim.setTime(rs.getDate("datafim"));
				tarefa.setDatafim(dataFim);
				
				tarefa.setResponsavel(rs.getString("responsavel"));		
				tarefa.setId_usuario(rs.getLong("id_usuario"));		
				tarefa.setOrdem(rs.getLong("ordem"));
				tarefa.setFinalizado(rs.getBoolean("finalizado"));
				
				tarefas.add(tarefa);
			}
			rs.close();
			stmt.close();
			return tarefas;
			
		}catch(SQLException e){
			throw new RuntimeException(e);
			
		}
	}
	
	public Tarefa getTarefa(Long id){
		try{
			PreparedStatement stmt = this.connection.prepareStatement("SELECT * FROM tarefas WHERE id=?"); 
			stmt.setLong(1, id);
			ResultSet rs = stmt.executeQuery();
			
			Tarefa tarefa = null;
			if(rs.next()){ 	
				tarefa = new Tarefa();
				
				tarefa.setId(rs.getLong("id"));
				tarefa.setNome(rs.getString("nome"));
				tarefa.setPrioridade(rs.getInt("prioridade"));
				tarefa.setStatus(rs.getString("status"));
				tarefa.setObservacao(rs.getString("observacao"));
				
				Calendar data = Calendar.getInstance();
				data.setTime(rs.getDate("datainicio"));
				tarefa.setDatainicio(data);
				
				data.setTime(rs.getDate("datafim"));
				tarefa.setDatafim(data);
				
				tarefa.setResponsavel(rs.getString("responsavel"));		
				tarefa.setId_usuario(rs.getLong("id_usuario"));		
				tarefa.setOrdem(rs.getLong("ordem"));
				tarefa.setFinalizado(rs.getBoolean("finalizado"));
				
				rs.close();
				stmt.close();
			}
		
		return tarefa;
			
		}catch(SQLException e){
			throw new RuntimeException(e);
			
		}		
	} 
	
	public List<Tarefa> getListTarefasIdUsuario(Long id_usuario){
		try{
			PreparedStatement stmt = this.connection.prepareStatement("SELECT * FROM tarefas WHERE id_usuario=?"); 
			stmt.setLong(1, id_usuario);
			
			
			ResultSet rs = stmt.executeQuery();
			
			List<Tarefa> tarefas = new ArrayList<Tarefa>();
			
			Tarefa tarefa = null;
			while(rs.next()){ 	
				tarefa = new Tarefa();
				
				tarefa.setId(rs.getLong("id"));
				tarefa.setNome(rs.getString("nome"));
				tarefa.setPrioridade(rs.getInt("prioridade"));
				tarefa.setStatus(rs.getString("status"));
				tarefa.setObservacao(rs.getString("observacao"));
				
				Calendar data = Calendar.getInstance();
				data.setTime(rs.getDate("datainicio"));
				tarefa.setDatainicio(data);
				
				data.setTime(rs.getDate("datafim"));
				tarefa.setDatafim(data);
				
				tarefa.setResponsavel(rs.getString("responsavel"));		
				tarefa.setId_usuario(rs.getLong("id_usuario"));		
				tarefa.setOrdem(rs.getLong("ordem"));
				tarefa.setFinalizado(rs.getBoolean("finalizado"));
				
				tarefas.add(tarefa);
			}
			rs.close();
			stmt.close();
		
			return tarefas;
			
			}catch(SQLException e){
				throw new RuntimeException(e);
				
			}		
	}
	
	
	public void finaliza(Long id){
		Tarefa tarefa = getTarefa(id);
		tarefa.setFinalizado(true);
		altera(tarefa);		
	}
	
	
}
