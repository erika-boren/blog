Rails.application.routes.draw do
  devise_for :users
  mount Ckeditor::Engine => '/ckeditor'

  resources :posts
  get 'tags/:tag', to: 'posts#index', as: "tag"
  root to: "posts#index"
end
