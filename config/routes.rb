Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  root "home#index"

  get "/selecao_estado", to: "deputados#selecao_estado"
  get "/deputados", to: "deputados#index"

  resources :deputados, only: [:index, :show]

  resources :despesas do
    collection do
      get :upload
      post :import
    end
  end
end
