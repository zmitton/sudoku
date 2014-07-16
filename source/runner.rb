#This file reads in a file with several sample boards.

require_relative 'sudoku'

# The file has newlines at the end of each line, so we call
# String#chomp to remove them.
board_string = File.readlines('sample.unsolved.txt').map{|line|
 line.chomp
}

game = Sudoku.new(board_string)

# Remember: this will just fill out what it can and not "guess"



game_boards = board_string


game_boards.each{|x|
board = Sudoku.new(x)
#board.print_board
solved_board = board.solve!
board.print_board
#puts board.full_board.inspect

}
