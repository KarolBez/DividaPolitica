class DespesaImportService
  require 'csv'

  def initialize(arquivo)
    @arquivo = arquivo
  end

  def processar
    sucesso = 0
    erros = 0

    CSV.foreach(@arquivo.path, headers: true, col_sep: ";", quote_char: '"', encoding: 'bom|utf-8') do |registro|
      begin
        next if registro["ideCadastro"].nil? || registro["ideDocumento"].nil?

        deputado = Deputado.find_or_initialize_by(
          ide_cadastro: registro["ideCadastro"]
        )

        if deputado.new_record?
          deputado.assign_attributes(
            nome: registro["txNomeParlamentar"],
            estado: registro["sgUF"],
            partido: registro["sgPartido"]
          )

          deputado.save!
        end

        despesa = deputado.despesas.find_or_initialize_by(
          ide_documento: registro["ideDocumento"]
        )

        if despesa.new_record?
          despesa.assign_attributes(
            data_emissao: registro["datEmissao"],
            fornecedor: registro["txtFornecedor"],
            cnpj_cpf: registro["txtCNPJCPF"],
            valor_documento: registro["vlrDocumento"],
            valor_glosa: registro["vlrGlosa"],
            valor_liquido: registro["vlrLiquido"],
            descricao: registro["txtDescricao"],
            subdescricao: registro["txtDescricaoEspecificacao"],
            nota_fiscal_url: registro["urlDocumento"]
          )

          despesa.save!
        end

        sucesso += 1
      rescue  StandardError => e
        erros += 1
        puts "Erro na linha #{registro.to_h}: #{e.message}"
      end
    end

    { sucesso: sucesso, erros: erros }
  end
end