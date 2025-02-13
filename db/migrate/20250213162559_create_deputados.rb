class CreateDeputados < ActiveRecord::Migration[7.1]
  def change
    create_table :deputados do |t|
      t.integer :ide_cadastro
      t.string :nome
      t.string :estado
      t.string :partido

      t.timestamps
    end
  end
end
