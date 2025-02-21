class DeputadosController < ApplicationController
  def selecao_estado
  end

  def index
    if params[:estado].present?
      @deputados = Deputado
        .select("deputados.*, COALESCE(SUM(despesas.valor_liquido), 0) AS total_despesas, MAX(valor_liquido) as maior_despesa")
        .joins("LEFT JOIN despesas ON despesas.deputado_id = deputados.id")
        .where(estado: params[:estado])
        .group("deputados.id")
        .order("total_despesas DESC")

      @deputados = @deputados.where("EXTRACT(YEAR FROM despesas.data_emissao) = ?", params[:ano].to_i) if params[:ano].present?

      @deputados = @deputados.where("LOWER(nome) LIKE ?", "%#{params[:nome].downcase}%") if params[:nome].present?

      @deputados = @deputados.where(partido: params[:partido]) if params[:partido].present?

      @deputados = @deputados.page(params[:page]).per(10)
    else
      redirect_to root_path, alert: "Por favor, selecione um estado para continuar."
    end
  end

  def show
    @deputado = Deputado.find(params[:id])
    @despesas = @deputado.despesas.order(valor_liquido: :desc)
    @maior_despesa = @despesas.first
    @total_despesas = @despesas.sum(:valor_liquido)
  end
end


Despesa.select("EXTRACT(YEAR FROM data_emissao)").where("EXTRACT(YEAR FROM data_emissao) > 2000")