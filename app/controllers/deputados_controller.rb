class DeputadosController < ApplicationController
  def selecao_estado
  end

  def index
    if params[:estado].present?
      @deputados = Deputado.where(estado: params[:estado]).order(:nome)
    else
      redirect_to root_path, alert: "Por favor, selecione um estado para continuar."
    end
  end
end