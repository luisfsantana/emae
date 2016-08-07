package br.com.mafes.memoria.jdbc.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import br.com.mafes.memoria.jdbc.controller.ConnectionFactory;
import br.com.mafes.memoria.jdbc.modelo.Peca;

public class PecaDAO {

private Connection connection;
	
	public PecaDAO(){
		this.connection = new ConnectionFactory().getConnection();
	}
	
	public void adiciona(Peca peca) {
		String sql = "INSERT INTO pecas " +
				"(quantidade, nome, estado, observacao, data, status, id_tarefa)" +
				"VALUES(?,?,?,?,?,?,?)";
		
		try{
			PreparedStatement stmt = connection.prepareStatement(sql);
			
			stmt.setInt(1, peca.getQuantidade());
			stmt.setString(2, peca.getNome());
			stmt.setString(3, peca.getEstado());
			stmt.setString(4, peca.getObservacao());
			stmt.setDate(5, new java.sql.Date(peca.getData().getTimeInMillis()));
			stmt.setString(6, peca.getStatus());
			stmt.setLong(7, peca.getId_tarefa());
			
			stmt.execute();
			stmt.close();
			
		}catch(SQLException e){
			throw new RuntimeException(e);
		}
		
		
	}

	public void altera(Peca peca){
		String sql = "update pecas set quantidade=?, nome=?, estado=?, observacao=?, data=?, status=?, id_tarefa=? where id=?";
				
		try{
			PreparedStatement stmt = connection.prepareStatement(sql);
					
			stmt.setInt(1, peca.getQuantidade());
			stmt.setString(2, peca.getNome());
			stmt.setString(3, peca.getEstado());
			stmt.setString(4, peca.getObservacao());
			stmt.setDate(5, new java.sql.Date(peca.getData().getTimeInMillis()));
			stmt.setString(6, peca.getStatus());
			stmt.setLong(7, peca.getId_tarefa());
			stmt.setLong(8, peca.getId());

			stmt.execute();
			stmt.close();
		}catch(SQLException e){
			throw new RuntimeException(e);
		}
	}
	
	public void exclui(Peca peca){
		try{
			PreparedStatement stmt = connection.prepareStatement("delete from pecas where id=?");
			stmt.setLong(1, peca.getId());
			
			stmt.execute();
			stmt.close();
		}catch(SQLException e){
			throw new RuntimeException(e);
		}	
	}
	
	public List<Peca> getLista(){
		
		try{
			List<Peca> pecas = new ArrayList<Peca>();
			PreparedStatement stmt = this.connection.prepareStatement("SELECT * FROM pecas");  
			ResultSet rs = stmt.executeQuery();
			
			while(rs.next()){
				
				Peca peca = new Peca();
				peca.setId(rs.getLong("id"));
				peca.setQuantidade(Integer.parseInt(rs.getString("quantidade")));
				peca.setNome(rs.getString("nome"));
				peca.setEstado(rs.getString("estado"));
				peca.setObservacao(rs.getString("observacao"));

				Calendar data = Calendar.getInstance();
				data.setTime(rs.getDate("data"));
				peca.setData(data);
					
				peca.setStatus(rs.getString("status"));
				
				peca.setId_tarefa(rs.getLong("id_tarefa"));		
				
				pecas.add(peca);
			}
			rs.close();
			stmt.close();
			return pecas;
			
		}catch(SQLException e){
			throw new RuntimeException(e);
			
		}
	}
	
	public Peca getPeca(Long id){
		try{
			PreparedStatement stmt = this.connection.prepareStatement("SELECT * FROM pecas WHERE id=?"); 
			stmt.setLong(1, id);
			ResultSet rs = stmt.executeQuery();
			
			Peca peca = null;
			if(rs.next()){ 	
				peca = new Peca();
				
				peca = new Peca();
				peca.setId(rs.getLong("id"));
				peca.setQuantidade(rs.getInt("quantidade"));
				peca.setNome(rs.getString("nome"));
				peca.setEstado(rs.getString("estado"));
				peca.setObservacao(rs.getString("observacao"));

				Calendar data = Calendar.getInstance();
				data.setTime(rs.getDate("data"));
				peca.setData(data);
					
				peca.setStatus(rs.getString("status"));
				
				peca.setId_tarefa(rs.getLong("id_tarefa"));
				rs.close();
				stmt.close();
			}
		
		return peca;
			
		}catch(SQLException e){
			throw new RuntimeException(e);
			
		}		
	} 
	
	public List<Peca> getListPecasIdTarefa(Long id_tarefa){
		try{
			PreparedStatement stmt = this.connection.prepareStatement("SELECT * FROM pecas WHERE id_tarefa=?"); 
			stmt.setLong(1, id_tarefa);
			
			
			ResultSet rs = stmt.executeQuery();
			
			List<Peca> pecas = new ArrayList<Peca>();
			
			Peca peca = null;
			while(rs.next()){ 	
				peca = new Peca();
				peca.setId(rs.getLong("id"));
				peca.setQuantidade(Integer.parseInt(rs.getString("quantidade")));
				peca.setNome(rs.getString("nome"));
				peca.setEstado(rs.getString("estado"));
				peca.setObservacao(rs.getString("observacao"));

				Calendar data = Calendar.getInstance();
				data.setTime(rs.getDate("data"));
				peca.setData(data);
					
				peca.setStatus(rs.getString("status"));
				
				peca.setId_tarefa(rs.getLong("id_tarefa"));		
				
				pecas.add(peca);
				
				pecas.add(peca);
			}
			rs.close();
			stmt.close();
		
			return pecas;
			
			}catch(SQLException e){
				throw new RuntimeException(e);
				
			}		
	}
	
	
}
