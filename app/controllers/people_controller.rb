class PeopleController < ApplicationController
  def show
    url = params[:url]
    response = RestClient.get url
    f = JSON.parse(response.body)
    @person = Hash.new
    @person["name"] = f["name"]
    @person["height"] = f["height"]
    @person["mass"] = f["mass"]
    @person["hair_color"] = f["hair_color"]
    @person["skin_color"] = f["skin_color"]
    @person["eye_color"] = f["eye_color"]
    @person["birth_year"] = f["birth_year"]
    @person["gender"] = f["gender"]
    url1 = f["homeworld"]
    r1 = RestClient.get url1
    f1 = JSON.parse(r1.body)
    @person["homeworld"] = f1["name"]
    @person["created_at_swapi"] = f["created"]
    @person["edited_at_swapi"] = f["edited"]
    @person["url"] = f["url"]
    @person["films"] = []
    @person["starships"] = []
    films_in_person = f["films"]
    starships_in_person = f["starships"]
    films_in_person.each do |p|
      film = OpenStruct.new
      response = RestClient.get p
      r = JSON.parse(response.body)
      film.name = r["title"]
      film.url = p
      @person["films"] << film
    end
    starships_in_person.each do |s|
      starship = OpenStruct.new
      response = RestClient.get s
      r = JSON.parse(response.body)
      starship.name = r["name"]
      starship.url = s
      @person["starships"] << starship
    end
    @person
  end

  def index
    last_page = false
    response = RestClient.get 'https://swapi.co/api/people/'
    response_parsed = JSON.parse(response.body)
    @people = []
    while !last_page
      response_parsed["results"].each do |f|
        new_params = Hash.new
        new_params["name"] = f["name"]
        new_params["height"] = f["height"]
        new_params["mass"] = f["mass"]
        new_params["hair_color"] = f["hair_color"]
        new_params["skin_color"] = f["skin_color"]
        new_params["eye_color"] = f["eye_color"]
        new_params["birth_year"] = f["birth_year"]
        new_params["gender"] = f["gender"]
        url1 = f["homeworld"]
        r1 = RestClient.get url1
        f1 = JSON.parse(r1.body)
        new_params["homeworld"] = f1["name"]
        new_params["created_at_swapi"] = f["created"]
        new_params["edited_at_swapi"] = f["edited"]
        new_params["url"] = f["url"]
        @people << new_params
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
