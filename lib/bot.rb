class Bot
  def initialize
    @dictionary = Array.new
    create_dictionary
  end

  def pick_word
    word = @dictionary[rand(@dictionary.length())].join()
    word.scan /\w/
  end

  private

  def create_dictionary
    File.open("5desk.txt", 'r') do |f|
      f.each_line do |line|
        @dictionary << line.split.map(&:to_s)
      end
    end
  end
end