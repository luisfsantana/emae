package br.com.mafes.memoria.jdbc.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import br.com.mafes.memoria.jdbc.controller.ConnectionFactory;
import br.com.mafes.memoria.jdbc.modelo.Usuario;

public class UsuarioDAO {

	private Connection connection;
	
	public UsuarioDAO(){
		this.connection = new ConnectionFactory().getConnection();
	}
	
	public void adiciona(Usuario usuario) {
		String sql = "INSERT INTO usuarios " +
				"(nome, login, senha, GRUPO) " +
				"VALUES(?,?,?,?)";
		
		try{
			PreparedStatement stmt = connection.prepareStatement(sql);
			
			stmt.setString(1, usuario.getNome());
			stmt.setString(2, usuario.getLogin());
			stmt.setString(3, usuario.getSenha());
			stmt.setString(4, usuario.getGrupo());
			
			stmt.execute();
			stmt.close();
			
		}catch(SQLException e){
			throw new RuntimeException(e);
		}
		
		
	}

	public void altera(Usuario usuario){
		String sql = "update usuarios set nome=?, login=?, senha=?, GRUPO=? where id=?";
		
		try{
			PreparedStatement stmt = connection.prepareStatement(sql);
					
			stmt.setString(1, usuario.getNome());
			stmt.setString(2, usuario.getLogin());
			stmt.setString(3, usuario.getSenha());
			stmt.setString(4, usuario.getGrupo());	
			stmt.setLong(5, usuario.getId());
			
			stmt.execute();
			stmt.close();
		}catch(SQLException e){
			throw new RuntimeException(e);
		}
	}
	
	public void exclui(Usuario usuario){
		try{
			PreparedStatement stmt = connection.prepareStatement("delete from usuarios where id=?");
			stmt.setLong(1, usuario.getId());
			
			stmt.execute();
			stmt.close();
		}catch(SQLException e){
			throw new RuntimeException(e);
		}	
	}
	
	public List<Usuario> getLista(){
		
		try{
			List<Usuario> usuarios = new ArrayList<Usuario>();
			PreparedStatement stmt = this.connection.prepareStatement("SELECT * FROM usuarios");  
			ResultSet rs = stmt.executeQuery();
			
			while(rs.next()){
				Usuario usuario = new Usuario();
				usuario.setId(rs.getLong("id"));
				usuario.setNome(rs.getString("nome"));
				usuario.setLogin(rs.getString("login"));
				usuario.setSenha(rs.getString("senha"));
				usuario.setGrupo(rs.getString("GRUPO"));

				usuarios.add(usuario);
			}
			rs.close();
			stmt.close();
			return usuarios;
			
		}catch(SQLException e){
			throw new RuntimeException(e);
			
		}
	}
	
	public Usuario getUsuario(Long id){
		try{
			PreparedStatement stmt = this.connection.prepareStatement("SELECT * FROM usuarios WHERE id=?"); 
			stmt.setLong(1, id);
			ResultSet rs = stmt.executeQuery();
			
			Usuario usuario = null;
			if(rs.next()){ 	
				usuario = new Usuario();
				
				usuario.setId(rs.getLong("id"));
				usuario.setNome(rs.getString("nome"));
				usuario.setLogin(rs.getString("login"));
				usuario.setSenha(rs.getString("senha"));
				usuario.setGrupo(rs.getString("GRUPO"));

				rs.close();
				stmt.close();
			}
		
		return usuario;
			
		}catch(SQLException e){
			throw new RuntimeException(e);
			
		}		
	}
	
	public Usuario getUsuarioLoginSenha(String login, String senha){
		try{
			PreparedStatement stmt = this.connection.prepareStatement("SELECT * FROM usuarios WHERE login=? and senha=?"); 
			stmt.setString(1, login);
			stmt.setString(2, senha);
			
			ResultSet rs = stmt.executeQuery();
			
			Usuario usuario = null;
			if(rs.next()){ 	
				usuario = new Usuario();
				
				usuario.setId(rs.getLong("id"));
				usuario.setNome(rs.getString("nome"));
				usuario.setLogin(rs.getString("login"));
				usuario.setSenha(rs.getString("senha"));
				usuario.setGrupo(rs.getString("GRUPO"));

				rs.close();
				stmt.close();
			}
		
		return usuario;
			
		}catch(SQLException e){
			throw new RuntimeException(e);
			
		}		
	}
	
	
	
}
