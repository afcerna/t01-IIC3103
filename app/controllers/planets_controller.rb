class PlanetsController < ApplicationController
  def show
    url = params[:url]
    response = RestClient.get url
    f = JSON.parse(response.body)
    @planet = Hash.new
    @planet["name"] = f["name"]
    @planet["rotation_period"] = f["rotation_period"]
    @planet["orbital_period"] = f["orbital_period"]
    @planet["diameter"] = f["diameter"]
    @planet["climate"] = f["climate"]
    @planet["gravity"] = f["gravity"]
    @planet["terrain"] = f["terrain"]
    @planet["surface_water"] = f["surface_water"]
    @planet["population"] = f["population"]
    @planet["created_at_swapi"] = f["created"]
    @planet["edited_at_swapi"] = f["edited"]
    @planet["url"] = f["url"]
    @planet["people"] = []
    @planet["films"] = []
    people_in_planet = f["residents"]
    films_in_planet = f["films"]
    people_in_planet.each do |p|
      person = OpenStruct.new
      response = RestClient.get p
      r = JSON.parse(response.body)
      person.name = r["name"]
      person.url = p
      @planet["people"] << person
    end
    films_in_planet.each do |s|
      film = OpenStruct.new
      response = RestClient.get s
      r = JSON.parse(response.body)
      film.title = r["title"]
      film.url = s
      @planet["films"] << film
    end
    @planet
  end

  def index
    last_page = false
    response = RestClient.get 'https://swapi.co/api/planets/'
    response_parsed = JSON.parse(response.body)
    @planets = []
    while !last_page
      response_parsed["results"].each do |f|
        new_params = Hash.new
        new_params["name"] = f["name"]
        new_params["rotation_period"] = f["rotation_period"]
        new_params["orbital_period"] = f["orbital_period"]
        new_params["diameter"] = f["diameter"]
        new_params["climate"] = f["climate"]
        new_params["gravity"] = f["gravity"]
        new_params["terrain"] = f["terrain"]
        new_params["surface_water"] = f["surface_water"]
        new_params["population"] = f["population"]
        new_params["created_at_swapi"] = f["created"]
        new_params["edited_at_swapi"] = f["edited"]
        new_params["url"] = f["url"]
        @planets << new_params
      end
      next_url = response_parsed["next"]
      if next_url
        response = RestClient.get(next_url)
        response_parsed = JSON.parse(response.body)
      else
        last_page = true
      end
    end
    @people
  end
end
