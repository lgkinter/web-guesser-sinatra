require 'sinatra'
require 'sinatra/reloader'

NUMBER = rand(100)

def check(guess)
  if guess > NUMBER + 5
    "Way too high!"
  elsif guess > NUMBER
    "Too high!"
  elsif guess < NUMBER - 5
    "Way too low!"
  elsif guess < NUMBER
    "Too low!"
  else
    "You got it right!"
  end
end

get '/' do
  guess = params['guess'].to_i
  message = check(guess)
  erb :index, :locals => {:number => NUMBER, :message => message}
end
