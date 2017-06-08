Rails.application.routes.draw do
  get 'users/new'
  get '/about', to: 'static_pages#about'
  get '/help', to: 'static_pages#help'
  get '/contact', to: 'static_pages#contact'
  get '/signup', to: 'users#new'
  root 'static_pages#home'
end
