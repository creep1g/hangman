require_relative 'game.rb'
require 'date'
require 'yaml'

def intro
  puts                 "                  Welcome to HANGMAN!"
  puts "The rules are simple, the computer will choose a word"
  puts     "and all you have to do is guess the right letters"
  puts  "Each missed letter counts as a part of the mans body"
  puts       "so choose your letters wisely or you will lose!"
  puts "You can type 'save' at any time to save your progress"
  start
end

def start
  puts "Do you want to start a new game or load a saved game?[N/L]"
  loop do
    choice = gets.chomp.downcase()
    if choice == 'l'
      load_game
     break
    elsif choice == 'n'
      start_new_game
      break
    else
      puts "Type 'L' to load a save or type 'N' to start a new game"
    end
  end
end

def load
  game_files = Dir.entries("save_games").select { |f| f.include?(".sav") }
  game_files.each_with_index do |filename, index|
    puts "[#{index}] #{filename}"
  end

  print ": "
  index = gets.chomp
  game_file = "save_games/#{game_files[index.to_i]}"
  yaml = File.open(game_file).read
  YAML::load(yaml)
end

def start_new_game
  $game = Game.new
  $word = $game.pick_word
  $game.create_board($word.length())
  game()
end

def load_game
  $game = load
  puts $game.word
  game()
end

def restart
  puts "Would you like to play a new game or load from a save?[N/L]"
  puts "Type 'quit' to save and quit."
  loop do
    choice = gets.chomp.downcase()
    if choice == 'n'
      start_new_game
      break
    elsif choice == 'l'
      load_game
      break
    elsif choice == 'quit'
      $game.save
      break
    end
  end

end

def game_lost
  if $game.missed_letters.split(", ").length() == 8 ||
     $game.board_to_s.split("").include?("_")
      puts "You hung that poor man!"
      puts "The secret word was: #{$word.join("")}"
      restart
      return true
  else
    return false
  end
end

def guess
  print "Guess: "
  guess = gets.chomp.downcase()
  loop do
    if guess == 'save'
      $game.save()
      break 
    elsif !('a'..'z').include? guess
      loop do
        puts "You can only guess letters"
        print               "Try again: "
        guess = gets.chomp.downcase()
        break if ('a'..'z').include? guess
      end
      break
    elsif guess.length() > 1 || guess.length() < 1 
      puts "You can only guess one letter!"
      print                   "Try again:"
      guess = gets.chomp.downcase()
    else
      break
    end
  end
  return true if guess == 'save'
  $game.check_guess(guess)
  return false
end

def game()
  i = 0
  while i != 8
    puts $game.board_to_s
    puts $game.missed_letters unless $game.missed_letters.length() == 16
    break if guess == true
    restart() if $game.game_won? == true
    i = $game.missed_letters.split(", ").length()
  end
  i == 8 if game_lost() == true
end

intro()
