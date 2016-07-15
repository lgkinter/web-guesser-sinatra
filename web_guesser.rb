require 'sinatra'
require 'sinatra/reloader'

set :number, rand(100)

def check_guess(guess)
  if guess > settings.number + 5
    "Way too high!"
  elsif guess > settings.number
    "Too high!"
  elsif guess < settings.number - 5
    "Way too low!"
  elsif guess < settings.number
    "Too low!"
  else
    "You got it right!"
  end
end

get '/' do
  guess = params['guess'].to_i
  message = check_guess(guess)
  erb :index, :locals => {:number => settings.number, :message => message}
end
