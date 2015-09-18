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
      $name = session[:name]
      $board1.place(Ship.aircraft_carrier, session[:position1], params[:orientation1])
      $board1.place(Ship.battleship, session[:position2], params[:orientation2])
      $board1.place(Ship.destroyer, session[:position3], params[:orientation3])
      $board1.place(Ship.submarine, session[:position4], params[:orientation4])
      $board1.place(Ship.patrol_boat, session[:position5], params[:orientation5])
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
    session[:position1] = params[:position1].to_sym
    session[:orientation1] = params[:orientation1].to_sym
    session[:position2] = params[:position2].to_sym
    session[:orientation2] = params[:orientation2].to_sym
    session[:position3] = params[:position3].to_sym
    session[:orientation3] = params[:orientation3].to_sym
    session[:position4] = params[:position4].to_sym
    session[:orientation4] = params[:orientation4].to_sym
    session[:position5] = params[:position5].to_sym
    session[:orientation5] = params[:orientation5].to_sym
    redirect ('/board')
  end

  post '/fire' do
    session[:fire_position] = params[:fire_position].to_sym
    redirect ('/fire')
  end

  get '/fire' do
    $name = session[:name]
    $board1.shoot_at(session[:fire_position])
    erb :fire
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
