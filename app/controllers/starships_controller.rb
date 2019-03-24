class StarshipsController < ApplicationController
  def show
    url = params[:url]
    response = RestClient.get url
    f = JSON.parse(response.body)
    @starship = Hash.new
    @starship["name"] = f["name"]
    @starship["model"] = f["model"]
    @starship["manufacturer"] = f["manufacturer"]
    @starship["cost_in_credits"] = f["cost_in_credits"]
    @starship["length"] = f["length"]
    @starship["max_atmosphering_speed"] = f["max_atmosphering_speed"]
    @starship["crew"] = f["crew"]
    @starship["passengers"] = f["passengers"]
    @starship["cargo_capacity"] = f["cargo_capacity"]
    @starship["consumables"] = f["consumables"]
    @starship["hyperdrive_rating"] = f["hyperdrive_rating"]
    @starship["MGLT"] = f["MGLT"]
    @starship["starship_class"] = f["starship_class"]
    @starship["created_at_swapi"] = f["created"]
    @starship["edited_at_swapi"] = f["edited"]
    @starship["url"] = f["url"]
    @starship["pilots"] = []
    @starship["films"] = []
    people_in_starship = f["pilots"]
    films_in_starship = f["films"]
    people_in_starship.each do |p|
      person = OpenStruct.new
      response = RestClient.get p
      r = JSON.parse(response.body)
      person.name = r["name"]
      person.url = p
      @starship["people"] << person
    end
    films_in_starship.each do |s|
      film = OpenStruct.new
      response = RestClient.get s
      r = JSON.parse(response.body)
      film.title = r["title"]
      film.url = s
      @starship["films"] << film
    end
    @starship
  end

  def index
    last_page = false
    response = RestClient.get 'https://swapi.co/api/starships/'
    response_parsed = JSON.parse(response.body)
    @starships = []
    while !last_page
      response_parsed["results"].each do |f|
        new_params = Hash.new
        new_params["name"] = f["name"]
        new_params["model"] = f["model"]
        new_params["manufacturer"] = f["manufacturer"]
        new_params["cost_in_credits"] = f["cost_in_credits"]
        new_params["length"] = f["length"]
        new_params["max_atmosphering_speed"] = f["max_atmosphering_speed"]
        new_params["crew"] = f["crew"]
        new_params["passengers"] = f["passengers"]
        new_params["cargo_capacity"] = f["cargo_capacity"]
        new_params["consumables"] = f["consumables"]
        new_params["hyperdrive_rating"] = f["hyperdrive_rating"]
        new_params["MGLT"] = f["MGLT"]
        new_params["starship_class"] = f["starship_class"]
        new_params["created_at_swapi"] = f["created"]
        new_params["edited_at_swapi"] = f["edited"]
        new_params["url"] = f["url"]
        @starships << new_params
      end
      next_url = response_parsed["next"]
      if next_url
        response = RestClient.get(next_url)
        response_parsed = JSON.parse(response.body)
      else
        last_page = true
      end
    end
    @starships
  end
end
