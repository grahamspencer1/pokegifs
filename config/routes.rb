Rails.application.routes.draw do

  resources :pokemon, only: %i(index show)

  root "pokemon#index"

  get 'pokemon' => 'pokemon#index'

end
