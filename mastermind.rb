class MasterMind

  def initialize
    puts "Welcome to MASTERMIND"
    puts "Would you like to (p)lay, read the (i)nstructions, or (q)uit?"
    @game_mode = gets.chomp.downcase
    play_game?
  end

  def play_game?
    if @game_mode == 'p'
      game = GamePlay.new
      game.start
    elsif @game_mode == 'i'
      instructions
    elsif @game_mode == 'q'
      quit
    else
      puts "I don't know that command"
      quit
    end
  end

  def instructions
    puts "A sequence of exactly four colors (r)ed, (g)reen, (b)lue, and (y)ellow will be randomly generated."
    puts "You must guess the exact sequence of colors to score."
    puts "Would you like to (p)lay or (q)uit?"
    @game_mode = gets.chomp.downcase
    play_game?
  end

  def quit
    puts "Thanks for playing"
  end
end

class GamePlay

  def initialize
    @guess_number = 0
    @begin_time = Time.now
  end

  def available_colors
    %w(r g b y)
  end

  def start
    puts "I have generated a beginner sequence with four elements made up of: (r)ed,
         (g)reen, (b)lue, and (y)ellow. Use (q)uit at any time to end the game.
         What's your guess?"
    generate_colors
    @guess = gets.chomp.downcase
    play_mode?
  end

  def play_mode?
    if @guess == 'q'
      puts "Thanks for playing"
    elsif @guess == 'c'
      cheat
    else
      play
    end
  end

  def cheat
    puts "#{@color1}#{@color2}#{@color3}#{@color4}"
    @guess = gets.chomp.downcase
    play
  end

  def play
    if @guess.length > 4
      puts "Too long, guess again"
      @guess = gets.chomp.downcase
      play
    elsif @guess.length < 4
      puts "Too short, guess again"
      @guess = gets.chomp.downcase
      play
    elsif @guess == "#{@color1}#{@color2}#{@color3}#{@color4}"
      @guess_number += 1
      game_end
    else
      @guess_number += 1
      comparison
      @guess = gets.chomp.downcase
      play
    end
  end

  def comparison
    correct_elements = 0
    correct_positions = 0
    colors = [@color1, @color2, @color3, @color4]
    @guess.chars.each_with_index do |letter, index|
      correct_elements += 1 if letter.include?(@color1 || @color2 || @color3 || @color4)
      correct_positions += 1 if letter == colors[index]
    end
    puts "#{@guess.upcase} has #{correct_elements} of the correct elements with
    #{correct_positions} in the correct positions. This is your #{@guess_number}
    guess."
  end

  def game_end
    @end_time = Time.now
    game_time = (@end_time - @begin_time).round(0)
    minutes = game_time/60
    seconds = game_time.round(1)
    puts "Congratulations! You guessed the sequence '#{@color1}#{@color2}#{@color3}#{@color4}' in #{@guess_number} guesses in over
          #{minutes} minutes, #{seconds} seconds."
    puts "Do you want to (p)lay again or (q)uit?"
    mode = gets.chomp.downcase
    play_again?(mode)
  end

  def play_again?(mode)
    if mode == 'p'
      @guess_number = 0
      @begin_time = Time.now
      start
    else
      puts "Thanks for Playing"
    end
  end

  def generate_colors
    @color1 = available_colors.sample
    @color2 = available_colors.sample
    @color3 = available_colors.sample
    @color4 = available_colors.sample
  end
end

MasterMind.new
