require 'csv'

csv_file = Rails.root.join('db', 'seeds', 'Ano-2025.csv')

puts "Importando os dados do CSV. Por gentileza aguarde..."

total_deputados = 0
total_despesas = 0
erros = 0

CSV.foreach(csv_file, headers: true, col_sep: ";", quote_char: '"', encoding: 'bom|utf-8') do |row|
  begin
    next if row["ideCadastro"].nil? || row["ideDocumento"].nil?

    deputado = Deputado.find_or_initialize_by(
      ide_cadastro: row["ideCadastro"]
    )

    if deputado.new_record?
      deputado.assign_attributes(
        nome: row["txNomeParlamentar"],
        estado: row["sgUF"],
        partido: row["sgPartido"]
      )
      
      deputado.save!
      total_deputados += 1
    end

    despesa = deputado.despesas.find_or_initialize_by(
      ide_documento: row["ideDocumento"]
    ) 

    if despesa.new_record?
      despesa.assign_attributes(
        data_emissao: row["datEmissao"],
        fornecedor: row["txtFornecedor"],
        cnpj_cpf: row["txtCNPJCPF"],
        valor_documento: row["vlrDocumento"],
        valor_glosa: row["vlrGlosa"],
        valor_liquido: row["vlrLiquido"],
        descricao: row["txtDescricao"],
        subdescricao: row["txtDescricaoEspecificacao"],
        nota_fiscal_url: row["urlDocumento"]
      )

      despesa.save!
      total_despesas += 1
    end
  rescue StandardError => e
    erros += 1
    puts "Erro na linha #{row.to_h}: #{e.message}"
  end
end

puts "Importação conluída!"
puts "Total de Deputados importados: #{total_deputados}"
puts "Total de Despesas importadas: #{total_despesas}"
puts "Erros encontrados: #{erros}"