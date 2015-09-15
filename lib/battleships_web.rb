require 'sinatra/base'

class battle_ships_september < Sinatra::Base
  get '/' do
    'Hello battle_ships_september!'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
