package br.com.mafes.memoria.jdbc.modelo;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotEmpty;

public class Usuario {

		private Long id;
		
		@NotNull(message="{usuario.nome.null}") 
		@NotEmpty(message="{usuario.nome.vazia}")
		private String nome;
		
		@NotNull(message="{usuario.login.null}") 
		@NotEmpty(message="{usuario.login.vazia}")
		private String login;
		
		@NotNull(message="{usuario.senha.null}") 
		@NotEmpty(message="{usuario.senha.vazia}")
		@Size(min=6, message="{usuario.observacao.pequena}")
		private String senha;
		
		private String grupo;
		
		public Long getId() {
			return id;
		}
		public void setId(Long id) {
			this.id = id;
		}
		public String getLogin() {
			return login;
		}
		public void setLogin(String login) {
			this.login = login;
		}
		public String getNome() {
			return nome;
		}
		public void setNome(String nome) {
			this.nome = nome;
		}
		public String getSenha() {
			return senha;
		}
		public void setSenha(String senha) {
			this.senha = senha;
		}
		public String getGrupo() {
			return grupo;
		}
		public void setGrupo(String grupo) {
			this.grupo = grupo;
		}
		
		
		
}
