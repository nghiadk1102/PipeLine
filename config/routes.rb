Rails.application.routes.draw do
  devise_for :users
  root "plainpage#index"
  post "/filterline", to: "filterline#filter"
  resources :pipelines
  resources :lines
  resources :intersect_marks
  resources :posts
  get "/create_posts", to: "posts#add"
end
