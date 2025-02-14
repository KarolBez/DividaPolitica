class HomeController < ApplicationController
  def index
    @total_deputados = Deputado.count
    @total_despesas = Despesa.count
    @gastos_totais = Despesa.sum(:valor_liquido)

    @deputados_por_estado = Deputado.group(:estado).order(:estado).count
    @gastos_por_estado = Despesa.joins(:deputado).group("deputados.estado").sum(:valor_liquido)
  end
end