Rails.application.routes.draw do
  devise_for :users
  root "plainpage#index"
  post "/filterline", to: "filterline#filter"
  resources :pipelines, except: [:show, :edit]
  resources :lines, only: [:index, :show, :create, :destroy]
  resources :intersect_marks, only: :index
  resources :posts, only: [:index, :create, :show]
  resources :contruction_types, except: [:show, :edit]
  resources :contructions
  get "/create_posts", to: "posts#add"
end
