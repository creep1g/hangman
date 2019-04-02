class Game
  def initialize()
    @board = []
    @missed = Array.new
  end

  def create_board(length)
    length.times {@board << "_"}
  end

  def check_guess(guess, word)
    if word.include?(guess)
      update_board(guess, word)
    elsif @missed.include?(guess)
      #you have already guessed this!
      return false
    else
      @missed << guess
    end
  end

  def update_board(guess, word)
    word.each_with_index do |char, index|
      if char.downcase() == guess
        @board[index] = guess
      end
    end
  end

  def board_to_s
    return @board.join(" ")
  end

  def missed_letters
    return "Missed letters: #{@missed.join(", ")}" 
  end
end
