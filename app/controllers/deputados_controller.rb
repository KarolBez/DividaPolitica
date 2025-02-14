class DeputadosController < ApplicationController
  def selecao_estado
  end

  def index
    if params[:estado].present?
      @deputados = Deputado
        .select("deputados.*, COALESCE(SUM(despesas.valor_liquido), 0) AS total_despesas")
        .joins("LEFT JOIN despesas ON despesas.deputado_id = deputados.id")
        .where(estado: params[:estado])
        .group("deputados.id")
        .order("total_despesas DESC")
        .page(params[:page])
        .per(10)
    else
      redirect_to root_path, alert: "Por favor, selecione um estado para continuar."
    end
  end
end