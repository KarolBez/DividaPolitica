require 'rails_helper'

RSpec.describe Deputado, type: :model do
  describe "associações" do
    it { should have_many(:despesas).dependent(:destroy) }
  end

  describe "validações" do
    it { should validate_uniqueness_of(:ide_cadastro) }
    it { should validate_presence_of(:ide_cadastro) }
    it { should validate_presence_of(:nome) }

    it "não deve permitir caracteres não numéricos em ide_cadastro" do
      deputado = Deputado.new(ide_cadastro: "ABC123", nome: "Teste")
      expect(deputado).not_to be_valid
      expect(deputado.errors[:ide_cadastro]).to include(I18n.t('errors.messages.not_a_number'))
    end
  end

  describe "comportamento ao excluir" do
    it "deve excluir despesas associadas quando um deputado é removido" do
      deputado = Deputado.create!(ide_cadastro: 123456, nome: "Deputado Teste")
      deputado.despesas.create!(ide_documento: "XYZ123", data_emissao: Date.today)

      expect { deputado.destroy }.to change { Despesa.count }.by(-1)
    end
  end
end
