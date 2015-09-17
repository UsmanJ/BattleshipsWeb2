require 'sinatra/base'
require_relative 'game_setup'


class BattleshipsWeb < Sinatra::Base

  enable  :sessions
  set :views, proc {File.join(root, 'views')}


  get '/' do
    p $game =Game.new
    p $player = Player.new
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
    p $ship = Ship.aircraft_carrier
    p $position1
    p $orientation1
    p $position2
    p $orientation2
    p $board = Board.new(Cell)
    erb :board
  end

  post '/board' do
    $position1 = params[:position1].to_sym
    $orientation1 = params[:orientation1].to_sym
    $position2 = params[:position2].to_sym
    $orientation2 = params[:orientation2].to_sym
    $position3 = params[:position3].to_sym
    $orientation3 = params[:orientation3].to_sym
    $position4 = params[:position4].to_sym
    $orientation4 = params[:orientation4].to_sym
    $position5 = params[:position5].to_sym
    $orientation5 = params[:orientation5].to_sym
    $board.place($ship, $position1, $orientation1)
    redirect ('/board')
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
