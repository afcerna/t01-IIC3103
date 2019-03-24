class FilmsController < ApplicationController
  def show
    url = params[:url]
    response = RestClient.get url
    f = JSON.parse(response.body)
    @film = Hash.new
    @film["title"] = f["title"]
    @film["episode_id"] = f["episode_id"]
    @film["opening_crawl"] = f["opening_crawl"]
    @film["director"] = f["director"]
    @film["producer"] = f["producer"]
    @film["release_date"] = f["release_date"]
    @film["created_at_swapi"] = f["created"]
    @film["edited_at_swapi"] = f["edited"]
    @film["url"] = f["url"]
    @film["characters"] = []
    @film["planets"] = []
    @film["starships"] = []
    people_in_film = f["characters"]
    planets_in_film = f["planets"]
    starships_in_film = f["starships"]
    people_in_film.each do |p|
      person = OpenStruct.new
      response = RestClient.get p
      r = JSON.parse(response.body)
      person.name = r["name"]
      person.url = p
      @film["characters"] << person
    end
    planets_in_film.each do |p|
      planet = OpenStruct.new
      response = RestClient.get p
      r = JSON.parse(response.body)
      planet.name = r["name"]
      planet.url = p
      @film["planets"] << planet
    end
    starships_in_film.each do |s|
      starship = OpenStruct.new
      response = RestClient.get s
      r = JSON.parse(response.body)
      starship.name = r["name"]
      starship.url = s
      @film["starships"] << starship
    end
    @film
  end

  def index
    last_page = false
    response = RestClient.get 'https://swapi.co/api/films/'
    response_parsed = JSON.parse(response.body)
    @films = []
    while !last_page
      response_parsed["results"].each do |f|
        new_params = Hash.new
        new_params["title"] = f["title"]
        new_params["episode_id"] = f["episode_id"]
        new_params["opening_crawl"] = f["opening_crawl"]
        new_params["director"] = f["director"]
        new_params["producer"] = f["producer"]
        new_params["release_date"] = f["release_date"]
        new_params["created_at_swapi"] = f["created"]
        new_params["edited_at_swapi"] = f["edited"]
        new_params["url"] = f["url"]
        @films << new_params
      end
      next_url = response_parsed["next"]
      if next_url
        response = RestClient.get(next_url)
        response_parsed = JSON.parse(response.body)
      else
        last_page = true
      end
    end
    @films
  end
end
