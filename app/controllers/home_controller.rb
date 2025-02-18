class HomeController < ApplicationController
  def index
    @total_deputados = Deputado.count
    @total_despesas = Despesa.count
    @gastos_totais = Despesa.sum(:valor_liquido)

    @exercicios_disponiveis = Despesa
                              .select("DISTINCT EXTRACT(YEAR FROM data_emissao) AS ano")
                              .where("EXTRACT(YEAR FROM data_emissao) > 2000")
                              .map { |d| d.ano.to_i }
                              .sort
  end
end