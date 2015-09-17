require 'sinatra/base'
require './lib/water'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/game'
require './lib/player'


class BattleshipsWeb < Sinatra::Base

  enable  :sessions
  set :views, proc {File.join(root, 'views')}

  p @game =Game.new
  p $player = Player.new

  get '/' do
    erb :index
  end

  get '/newgame' do
    "What's your name?"
    p $name = params[:name]
    p $player.name = params[:name]
    p session[:name] = params[:name]
    erb :new_game
  end

  get '/board' do
    p session[:name]
    p $player
    erb :board
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
