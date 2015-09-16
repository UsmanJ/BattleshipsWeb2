require 'sinatra/base'
require_relative 'water'
require_relative 'ship'
require_relative 'cell'
require_relative 'board'
require_relative 'game'


class BattleshipsWeb < Sinatra::Base
  set :views, proc {File.join(root, '..', 'views')}
  get '/' do
   erb :index
  end

  get '/newgame' do
    "What's your name?"
    @visitor = params[:name]
erb :player1
  end

  get '/add' do
  number_1 = params[:number_1]
  number_2 = params[:number_2]
  @result = Calculator.add(number_1, number_2)
  erb :result
  end

  get '/test_board' do

    erb :test_board
    erb :test_board1
  end

# get '/new_game' do
#   erb :new_game
# end





  # start the server if ruby file executed directly
  run! if app_file == $0
end
