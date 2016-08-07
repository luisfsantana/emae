package br.com.mafes.memoria.jdbc.modelo;

import java.util.Calendar;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.format.annotation.DateTimeFormat;


public class Tarefa {

	private Long id;
	private Integer prioridade;
	private String status;
	
	@NotNull(message="{tarefa.nome.null}") 
	@NotEmpty(message="{tarefa.nome.vazia}")
	private String nome;
	
	@NotNull(message="{tarefa.observacao.vazia}") 
	@Size(min=5, message="{tarefa.observacao.pequena}")
	private String observacao;
	
	@DateTimeFormat(pattern = "dd/MM/yyyy") 
	@NotNull(message="{tarefa.datainicio.vazia}")  
	private Calendar datainicio;
	
	
	@DateTimeFormat(pattern = "dd/MM/yyyy")  
	@NotNull(message="{tarefa.datafim.vazia}")  
	private Calendar datafim;
	
	private String responsavel;
	private Long id_usuario;
	private Long ordem;
	private Boolean finalizado;
	
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public Integer getPrioridade() {
		return prioridade;
	}
	public void setPrioridade(Integer prioridade) {
		this.prioridade = prioridade;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getNome() {
		return nome;
	}
	public void setNome(String nome) {
		this.nome = nome;
	}
	public String getObservacao() {
		return observacao;
	}
	public void setObservacao(String observacao) {
		this.observacao = observacao;
	}
	
	public Calendar getDatainicio() {
		return datainicio;
	}
	public void setDatainicio(Calendar datainicio) {
		this.datainicio = datainicio;
	}
	public Calendar getDatafim() {
		return datafim;
	}
	public void setDatafim(Calendar datafim) {
		this.datafim = datafim;
	}
	public String getResponsavel() {
		return responsavel;
	}
	public void setResponsavel(String responsavel) {
		this.responsavel = responsavel;
	}
	public Long getId_usuario() {
		return id_usuario;
	}
	public void setId_usuario(Long id_usuario) {
		this.id_usuario = id_usuario;
	}
	public Long getOrdem() {
		return ordem;
	}
	public void setOrdem(Long ordem) {
		this.ordem = ordem;
	}
	public Boolean getFinalizado() {
		return finalizado;
	}
	public void setFinalizado(Boolean finalizado) {
		this.finalizado = finalizado;
	}
	

	
	
}
