class Game
  def initialize()
    @board = []
    @missed = Array.new
    @word = Array.new
  end

  def create_board(length)
    length.times {@board << "_"}
  end

  def check_guess(guess)
    if @word.include?(guess)
      update_board(guess, @word)
    elsif guess == 'save'
    elsif @missed.include?(guess)
      #you have already guessed this!
      return false
    else
      @missed << guess
    end
  end

  def pick_word
    dictionary = Array.new
    File.open("5desk.txt", 'r') do |f|
      f.each_line do |line|
        dictionary << line.split.map(&:to_s)
      end
    end
    @word = dictionary[rand(dictionary.length())].join().downcase()
    @word = @word.scan /\w/
    return @word
  end

  def word
    return @word
  end

  def game_won?()

    if @board.include?("_")
      return false
    else
      puts @board.join("").capitalize()
      puts "Congratulations You WON!"
      return true
    end
  end

  def save()
    yaml = YAML::dump(self)
    Dir.mkdir("save_games") unless Dir.exists? "save_games"
    filename = "save_games/#{DateTime.now.to_s}.sav"
    save_file = File.new(filename, 'w')
    save_file.write(yaml)
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
