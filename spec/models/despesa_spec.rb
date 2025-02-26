require 'rails_helper'

RSpec.describe Despesa, type: :model do
  describe "associações" do
    it { should belong_to(:deputado) }
  end

  describe "validações" do
    let!(:deputado) { Deputado.create!(ide_cadastro: 123456, nome: "Teste 1") }

    subject { Despesa.new(ide_documento: "123456ABC", deputado: deputado) }

    it { should validate_uniqueness_of(:ide_documento) }
    it { should validate_presence_of(:ide_documento) }

    it "não deve ser válida sem um deputado associado" do
      despesa = Despesa.new(ide_documento: "789XYZ")
      expect(despesa).not_to be_valid
      expect(despesa.errors[:deputado]).to include("deve existir")
    end

    it "não deve permitir ide_documento vazio" do
      despesa = Despesa.new(ide_documento: "", deputado: deputado)
      expect(despesa).not_to be_valid
      expect(despesa.errors[:ide_documento]).to include("não pode ficar em branco")
    end

    it "não deve permitir ide_documento nulo" do
      despesa = Despesa.new(ide_documento: nil, deputado: deputado)
      expect(despesa).not_to be_valid
      expect(despesa.errors[:ide_documento]).to include("não pode ficar em branco")
    end
  end
end
