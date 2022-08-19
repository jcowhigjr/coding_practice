module Test
  # def initialize; end

  def self.make_negative(num)
    #   Enter Code Here
    -num.abs
  end

  # Game of Zero is a game
  # count the number of moves
  # valid moves move the number of positions to the right as the value
  # at the current position
  class Game
    attr_reader :answer, :board

    def initialize(str = "")
      # raise StandardError, 'board empty' if board.empty?
      @board = str.split(",").map(&:to_i)
      @position = 0
      @moves = 0
      @direction = "move_right"
      @current_value = @board[@position]
    end

    def move
      raise StandardError if @moves > 20

      return unless move_right? || move_left?

      @direction = "stop" if @current_value == 0
      @direction = "stop" if @current_value == -1

      case @direction
      when "move_right"
        move_right if move_right?
      when "move_left"
        move_left if move_left?
      when "stop"
        @stop_position = @position
        @answer = @moves if @current_value == 0
        @answer = -1 if @current_value == -1
      else
        raise StandardError
      end
      # puts 'after: ' + inspect
    end

    private

    def move_right?
      @position + @current_value < @board.length
    end

    def move_left?
      (@position - @current_value) >= -1
    end

    def move_right
      index = @position + @current_value
      if @board[index].present?
        @board[@position] = -1
        @position = index
        @moves += 1
        @current_value = @board[index]
        @direction = "move_left"
        @direction = "stop" if @current_value == 0
        @direction = "stop" if @current_value == -1
      end
    end

    def move_left
      index = @position - @current_value
      if @board[index].present?
        @board[@position] = -1
        @position = index
        @moves += 1
        @current_value = @board[index]
        @direction = "move_right"
        @direction = "stop" if @current_value == 0
        @direction = "stop" if @current_value == -1
      end
    end
  end

  def self.play_game_of_zero(str = "")
    @game = Test::Game.new(str)
    @game.move until @game.answer
    @game.answer
  end
end
