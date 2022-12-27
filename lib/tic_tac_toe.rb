require 'pry'

class TicTacToe
    attr_accessor :board

    def initialize(board = [" "," "," "," "," "," "," "," "," "])
        @board = board
        play
    end

    WIN_COMBINATIONS = [
        [0,1,2],
        [3,4,5],
        [6,7,8],
        [0,3,6],
        [1,4,7],
        [2,5,8],
        [2,4,6],
        [0,4,8]
    ]

    def display_board
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]}\n #{@board[3]} | #{@board[4]} | #{@board[5]}\n #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end

    def input_to_index(string)
        string_to_index = string.to_i
        string_to_index - 1
    end

    def move(index, token = "X")
        @board[index] = token
    end

    def position_taken?(index)
        if (@board[index] == " ") || (@board[index] == "") || (@board[index] == nil) 
            return false
        else
            return true
        end
    end

    def valid_move?(index)
        if index >= 0 && index <= 8 && position_taken?(index) == false
            return true
        else
            return false
        end
    end

    def turn_count
        counter = @board.select { |element| element != " " }.length
        counter
    end

    def current_player
        turn_count % 2 == 0 ? "X" : "O"
    end

    def turn
        puts "Choose a space using the numbers 1 - 9."
        choice = gets
        player_move = input_to_index(choice)
        if valid_move?(player_move)
            move(player_move,current_player)
        else valid_move?(player_move) == false
            turn
        end
        display_board
    end

    def won?
        board_config = []
        winning_index = []
        WIN_COMBINATIONS.each do |win_combo|
            win_combo.each_with_index do |num, index|
                board_config << @board[num]
                winning_index << index
            end
            if board_config == ["O", "O", "O"] || board_config == ["X", "X", "X"]
                board_config = []
                return win_combo
                break
            else
                board_config = []
            end
        end
        false
    end
        # @board.select.with_index do |space, index|
        #     if space == "X"
        #         index
        #     end
        # end

    def full?
        @board.all? {|i| i == "X" || i == "O"}
    end

    def draw?
        if won? == false && full? == true
            return true
        elsif won? == false && full? == true
            return false
        else won? == true
            return false
        end
    end

    def over?
        if draw? == true || won? == true || full? == true
            return true
        end
    end

    def winner
        if won?
            return @board[won?[0]]
        end
    end

    def play
        while over? == false
            turn
        end
        if won? == true
            if winner == "X" 
                puts "Congratulations X!"
            else
                puts "Congratulations O!"
            end
        elsif draw?
            puts "Cat's Game!"
        end
    end


end
