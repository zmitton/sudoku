require 'sinatra'
require 'json'
require_relative 'sudoku'


get '/api/solve_string/:string' do
 content_type :json
	 if params[:string]
		@string = Game.new(params[:string])
	 end
 # @string
end

get '/:string' do
	if params[:string]
		@string = params[:string]
		@solution_string =  get_solution_string(params[:string])
	end
	erb :sudoku
end

get '/' do
	if params[:string]
		@string = params[:string]
		@solution_string =  get_solution_string(params[:string])
	end
	erb :sudoku
end


