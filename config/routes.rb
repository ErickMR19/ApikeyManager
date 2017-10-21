Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  # 
  root to: 'api_key_manager#index'
  
  #
  get '/find_duplicates/', to: 'api_key_manager#request_find_duplicates'
  
  #
  post '/api_key/create', to: 'api_key_manager#create'
  
end
