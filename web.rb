require 'sinatra'
require 'haml'
require 'sass'
require 'compass'
require 'json'

require_relative 'sudoku'

configure do
  Compass.configuration do |config|
    config.project_path = File.dirname(__FILE__)
    config.sass_dir = 'public/sass'
    config.http_path = "/"
		config.css_dir = "public/css"
		config.sass_dir = "public/sass"
		config.images_dir = "public/img"
		config.fonts_dir = "public/fonts"
		config.javascripts_dir = "public/js"
		config.relative_assets = true
		output_style = :compressed
		line_comments = false
  end

  set :haml, { :format => :html5 }
  set :scss, Compass.sass_engine_options
end

get './public/css/style.css' do
  scss :scss_file
end


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


