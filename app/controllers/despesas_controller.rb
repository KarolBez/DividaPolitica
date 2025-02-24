require 'csv'

class DespesasController < ApplicationController
  def upload
  end

  def import
    if params[:arquivo].present?
      resultado = DespesaImportService.new(params[:arquivo]).processar
      redirect_to root_path, notice: "Importação concluída!! #{resultado[:sucesso]} registros importados. #{resultado[:erros]} erros."
    else
      redirect_to upload_despesas_path, alert: "Por gentileza, selecione um arquivo CSV!!"
    end
  end
end