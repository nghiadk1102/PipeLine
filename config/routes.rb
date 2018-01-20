Rails.application.routes.draw do
  devise_for :users
  root "plainpage#index"
  post "/filterline", to: "filterline#filter"
end
