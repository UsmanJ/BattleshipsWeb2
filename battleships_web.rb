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

  get '/' do
    @game =Game.new
    erb :index
  end

  get '/newgame' do
    "What's your name?"
    $player1 = params[:name]
    erb :new_game
  end

  post '/newgame' do
    session[:name] = $player1
    session[:name]
    redirect ('/board')
  end

  get '/board' do
    p session[:name]
    p $player1
    erb :board
  end

# get '/new_game' do
#   erb :new_game
# end





  # start the server if ruby file executed directly
  run! if app_file == $0
end
