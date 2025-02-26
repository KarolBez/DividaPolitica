require 'rails_helper'

RSpec.describe "Deputados", type: :request do
  describe "GET /deputados" do
    let!(:deputado) { Deputado.create!(ide_cadastro: 123456, nome: "Teste 1", estado: "CE", partido: "ABC") }
    let!(:despesa) { Despesa.create!(deputado: deputado, ide_documento: 121212, valor_liquido: 100.0, data_emissao: Date.new(2024, 1, 1)) }

    context "quando um estado é informado" do
      it "retorna uma lista de deputados" do
        get deputados_path, params: { estado: "CE" }
        
        expect(response).to have_http_status(:success)
        expect(response.body).to include(deputado.nome)
      end
    end

    context "quando um estado NÃO é informado" do
      it "redireciona para a página inicial com alerta" do
        get deputados_path
        
        expect(response).to redirect_to(root_path)
        follow_redirect!
        expect(response.body).to include("Por favor, selecione um estado para continuar.")
      end
    end
  end

  describe "GET /deputados/:id" do
    let!(:deputado) { Deputado.create!(ide_cadastro: 789012, nome: "Deputado X", estado: "RJ", partido: "XYZ") }
    let!(:despesa1) { Despesa.create!(deputado: deputado, ide_documento: 343434,valor_liquido: 300.0, data_emissao: Date.new(2024, 1, 1)) }
    let!(:despesa2) { Despesa.create!(deputado: deputado, ide_documento: 565656,valor_liquido: 200.0, data_emissao: Date.new(2024, 2, 1)) }

    it "retorna os detalhes do deputado" do
      get deputado_path(deputado)
      
      expect(response).to have_http_status(:success)
      expect(response.body).to include(deputado.nome)
      expect(response.body).to include("300,00")
    end
  end
end
