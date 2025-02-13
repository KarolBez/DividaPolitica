Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  root "deputados#selecao_estado"
  
  get "/deputados", to: "deputados#index"
end
