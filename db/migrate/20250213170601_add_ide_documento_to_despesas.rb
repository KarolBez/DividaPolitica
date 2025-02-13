class AddIdeDocumentoToDespesas < ActiveRecord::Migration[7.1]
  def change
    add_column :despesas, :ide_documento, :string
    add_index :despesas, :ide_documento
  end
end
