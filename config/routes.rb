Rails.application.routes.draw do
  get 'starships/show', as: :show_starship
  get 'starships/index', as: :index_starships
  get 'planets/show', as: :show_planet
  get 'planets/index', as: :index_planets
  get 'people/show', as: :show_person
  get 'people/index', as: :index_people
  get 'films/show', as: :show_film
  get 'films/index', as: :index_films
  root 'films#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
