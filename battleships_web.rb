require 'sinatra/base'
require_relative 'game_setup'


class BattleshipsWeb < Sinatra::Base

  enable  :sessions
  set :views, proc {File.join(root, 'views')}


  # $aircraft = Ship.aircraft_carrier

  get '/' do
    # p $game =Game.new
    # p $player = Player.new
    erb :index
  end

  get '/new_game' do
    # p @name = params[:name]
    # p $player.name = params[:name]
    # p session[:name] = params[:name]
    erb :new_game
  end

  post '/new_game' do
    session[:name] = params[:name]
    redirect ('/new_game') if params[:name].empty?
    redirect ('/board')
  end

  get '/board' do
    if $board
      @name = session[:name]
      $board.place(Ship.aircraft_carrier, $position1, $orientation1)
      @grid = $board.print_board
    else
      $board = Board.new(Cell)
      @name = session[:name]
      @grid = $board.print_board
      # $board.place($aircraft, $position1, $orientation1)
      erb :board
    end
  end

  post '/board' do
    # @aircraft = Ship.aircraft_carrier
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
    redirect ('/board')
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
