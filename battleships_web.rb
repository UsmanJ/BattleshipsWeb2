require 'sinatra/base'
require_relative 'game_setup'


class BattleshipsWeb < Sinatra::Base

  enable  :sessions
  set :views, proc {File.join(root, 'views')}

  get '/' do
    erb :index
  end

  get '/new_game' do
    p $game = Game.new
    p $player1 = Player.new
    # p @name = params[:name]
    # p $player.name = params[:name]
    # p session[:name] = params[:name]
    erb :new_game
  end

  post '/new_game' do
    session[:name] = params[:name]
    $game.add_player($player1)
    redirect ('/new_game') if params[:name].empty?
    redirect ('/board')
  end

  get '/board' do
    if $board1
      @name = session[:name]
      $board1.place(Ship.aircraft_carrier, $position1, $orientation1)
      $board1.place(Ship.battleship, $position2, $orientation2)
      $board1.place(Ship.destroyer, $position3, $orientation3)
      $board1.place(Ship.submarine, $position4, $orientation4)
      $board1.place(Ship.patrol_boat, $position5, $orientation5)
      # @grid = $board1.print_board
      erb :board_game_on
    else
      $board1 = Board.new(Cell)
      $player1.board = $board1
      @name = session[:name]
      @grid = $board1.print_board
      p $game
      erb :board
    end
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
    redirect ('/board')
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
