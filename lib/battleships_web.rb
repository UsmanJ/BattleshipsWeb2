require 'sinatra/base'

class BattleshipsWeb < Sinatra::Base
  get '/' do
    'Hello we have done it our first test and we make some changes! and and so on '
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
