require 'rails_helper'

RSpec.describe DespesasController, type: :controller do
  describe 'GET #upload' do
    it 'retorna sucesso ao acessar a página de upload' do
      get :upload
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:upload)
    end
  end

  describe 'POST #import' do
    let(:arquivo_valido) { fixture_file_upload(Rails.root.join('spec/fixtures/despesas_validas.csv'), 'text/csv') }
    let(:arquivo_invalido) { fixture_file_upload(Rails.root.join('spec/fixtures/despesas_invalidas.csv'), 'text/csv') }

    context 'quando um arquivo CSV válido é enviado' do
      it 'redireciona para a página inicial com mensagem de sucesso' do
        allow_any_instance_of(DespesaImportService).to receive(:processar).and_return({ sucesso: 10, erros: 0 })

        post :import, params: { arquivo: arquivo_valido }

        expect(response).to redirect_to(root_path)
        expect(flash[:notice]).to eq('Importação concluída!! 10 registros importados. 0 erros.')
      end
    end

    context 'quando nenhum arquivo é enviado' do
      it 'redireciona para a página de upload com alerta' do
        post :import, params: { arquivo: nil }

        expect(response).to redirect_to(upload_despesas_path)
        expect(flash[:alert]).to eq('Por gentileza, selecione um arquivo CSV!!')
      end
    end

    context 'quando há erros na importação' do
      it 'redireciona com mensagem de erro' do
        allow_any_instance_of(DespesaImportService).to receive(:processar).and_return({ sucesso: 5, erros: 3 })

        post :import, params: { arquivo: arquivo_invalido }

        expect(response).to redirect_to(root_path)
        expect(flash[:notice]).to eq('Importação concluída!! 5 registros importados. 3 erros.')
      end
    end
  end
end
