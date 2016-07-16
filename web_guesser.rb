require 'sinatra'
require 'sinatra/reloader'

set :number, rand(100)
@@remaining_guesses = 5
@@correct_guess = settings.number

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

def game_over?(message)
  if @@remaining_guesses == 0 || message =~ /right/
    @@correct_guess = settings.number
    settings.number = rand(100)
    @@remaining_guesses = 5
    return true
  else
    @@correct_guess = settings.number
    return false
  end
end

get '/' do
  guess = params['guess'].to_i
  cheat = params['cheat']
  if params['guess']
    @@remaining_guesses -= 1
    message = check_guess(guess)
  else
    message = "Welcome! We've selected a random secret number from 0 to 100. What's your guess?"
  end
  game_over = game_over?(message)
  erb :index, :locals => {:number => @@correct_guess, :message => message, :game_over => game_over, :cheat_mode => cheat}
end
