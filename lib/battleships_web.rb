require 'sinatra/base'


class BattleshipsWeb < Sinatra::Base
  set :views, proc {File.join(root, '..', 'views')}
  get '/' do
   erb :index
  end

  get '/newgame' do
    "What's your name?"
  end

  get '/add' do
  number_1 = params[:number_1]
  number_2 = params[:number_2]
  p params
  @result = Calculator.add(number_1, number_2)
  erb :result
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
