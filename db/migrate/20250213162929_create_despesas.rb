class CreateDespesas < ActiveRecord::Migration[7.1]
  def change
    create_table :despesas do |t|
      t.references :deputado, null: false, foreign_key: true
      t.date :data_emissao
      t.string :fornecedor
      t.string :cnpj_cpf
      t.decimal :valor_documento
      t.decimal :valor_glosa
      t.decimal :valor_liquido
      t.string :descricao
      t.string :subdescricao
      t.string :nota_fiscal_url

      t.timestamps
    end
  end
end
