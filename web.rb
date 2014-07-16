require 'sinatra'
require 'json'
require_relative 'sudoku'


get '/api/solve_string/:string' do
 content_type :json
	 if params[:string]
		@string =  get_solution_string(params[:string])
	 end
	    params[:string]
end

get '/:string' do
	if params[:string]
		@string = params[:string]
		@solution_string =  get_solution_string(params[:string])
	end
	erb :sudoku
end






# game_boards = File.readlines('sample.unsolved.txt').map{|line|
#  line.chomp
# }



# game_boards.each{|x|
# board = Sudoku.new(x)
# #board.print_board
# solved_board = board.solve!
# board.print_board
# #puts board.full_board.inspect

# }
