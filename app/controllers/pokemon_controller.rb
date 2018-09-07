require "httparty"

class PokemonController < ApplicationController

  def index
    res = HTTParty.get("http://pokeapi.co/api/v2/pokemon/")
    body = JSON.parse(res.body)
    name = body["name"]
    id = body["id"]
    type = body["type"]

    res = HTTParty.get("https://api.giphy.com/v1/gifs/search?api_key=#{ENV["GIPHY_KEY"]}&q=pikachu&rating=g")
    body = JSON.parse(res.body)
    gif_url = body["data"][0]["url"]

    render json: { "name": body["name"], "id": body["id"], "types": body["types"]}
  end

  def show
    @id = params[:id]
    res = HTTParty.get("http://pokeapi.co/api/v2/pokemon/#{@id}")
    body = JSON.parse(res.body)

    gif_res = HTTParty.get("https://api.giphy.com/v1/gifs/search?api_key=#{ENV["GIPHY_KEY"]}&q=#{body["name"]}&rating=g")

    gif_body = JSON.parse(gif_res.body)
    puts gif_body
    url = gif_body["data"][0]["url"]
    render json: {"id": body["id"], "name": body["name"], "types": body["types"], "gif": url}

  end

end
