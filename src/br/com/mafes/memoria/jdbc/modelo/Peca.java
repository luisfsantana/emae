package br.com.mafes.memoria.jdbc.modelo;

import java.util.Calendar;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.format.annotation.DateTimeFormat;

public class Peca {
	
	private Long id;
	
	@NotNull(message="{peca.quantidade.null}") 
	private Integer quantidade;
	
	@NotNull(message="{peca.nome.null}") 
	@NotEmpty(message="{peca.nome.vazia}")
	private String nome;

	
	private String estado;
	
	@NotNull(message="{peca.observacao.null}") 
	@NotEmpty(message="{peca.observacao.vazia}")
	private String observacao;
	
	@DateTimeFormat(pattern = "dd/MM/yyyy") 
	@NotNull(message="{peca.data.vazia}")  
	private Calendar data;
	
	private String status;
	private Long id_tarefa;
	
	
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public Integer getQuantidade() {
		return quantidade;
	}
	public void setQuantidade(Integer quantidade) {
		this.quantidade = quantidade;
	}
	public String getNome() {
		return nome;
	}
	public void setNome(String nome) {
		this.nome = nome;
	}
	public String getEstado() {
		return estado;
	}
	public void setEstado(String estado) {
		this.estado = estado;
	}
	public String getObservacao() {
		return observacao;
	}
	public void setObservacao(String observacao) {
		this.observacao = observacao;
	}
	public Calendar getData() {
		return data;
	}
	public void setData(Calendar data) {
		this.data = data;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public Long getId_tarefa() {
		return id_tarefa;
	}
	public void setId_tarefa(Long id_tarefa) {
		this.id_tarefa = id_tarefa;
	}
	
	
}
