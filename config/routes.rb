Rails.application.routes.draw do
  
  get '/' => 'judge#index'
  post '/' => 'judge#index'
end
