# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2025_02_13_162929) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "deputados", force: :cascade do |t|
    t.integer "ide_cadastro"
    t.string "nome"
    t.string "estado"
    t.string "partido"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "despesas", force: :cascade do |t|
    t.bigint "deputado_id", null: false
    t.date "data_emissao"
    t.string "fornecedor"
    t.string "cnpj_cpf"
    t.decimal "valor_documento"
    t.decimal "valor_glosa"
    t.decimal "valor_liquido"
    t.string "descricao"
    t.string "subdescricao"
    t.string "nota_fiscal_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deputado_id"], name: "index_despesas_on_deputado_id"
  end

  add_foreign_key "despesas", "deputados"
end
