# frozen_string_literal: true

Rails.application.routes.draw do
  get '/' => 'hands#index'
  post '/' => 'hands#index'
end
