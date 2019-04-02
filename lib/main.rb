require_relative 'bot.rb'
require_relative 'game.rb'

bot = Bot.new
word = bot.pick_word
puts word
def game_won?(board)
  board = board.split()
  if board.include?("_")
    return false
  else
    puts board.join("").capitalize()
    puts "Congratulations You WON!"
    return true
  end
end

def game(word)
  game = Game.new
  game.create_board(word.length())
  i = 0
  while i != 8
    puts game.board_to_s
    puts game.missed_letters
    guess = gets.chomp.downcase()
    loop do
      if guess.length() > 1 || guess.length() < 1
        puts "You can only guess one letter!"
        puts "Try again:"
        guess = gets.chomp.downcase()
      else
        break
      end
    end
    
    game.check_guess(guess, word)
    if game_won?(game.board_to_s) == true
      break
    end
    i = game.missed_letters.split(", ").length()
  end
  puts "You hung that poor man!" if i == 8
end
game(word)