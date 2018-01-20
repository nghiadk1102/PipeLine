Rails.application.routes.draw do
  devise_for :users
  root "plainpage#index"
end
