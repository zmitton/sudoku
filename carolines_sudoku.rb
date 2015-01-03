class Sudoku

  def initialize(board_string)
    @board = create_board(board_string)
  end

  def create_board(string)
    digit_array = string.chars.map(&:to_i)
    digit_array.each_slice(9).to_a.each do |row|
      row.map! do |cell|
        cell.to_i == 0 ? (1..9).to_a : cell
      end
    end
  end

  def solved?
    @board.each do |row|
      row.each {|cell| return false if cell.is_a? Array}
    end
  end

  def solve!
    until solved?
      @board.each_with_index do |row, row_index|
        find_uniques(row)
        row.each_with_index do |cell, column_index|
          find_uniques(get_column(column_index))
          find_uniques(get_inner_block(row_index, column_index))
          if cell.kind_of? Array
            eliminate_cell_possibilities(cell, row_index, column_index)
            set_cell_value(cell, row, row_index, column_index)
          end
        end
      end
    end
  end

  def get_row(row_index)
    @board[row_index]
  end

  def get_column(column_index)
    @board.transpose[column_index]
  end

  def get_inner_block(row_index, column_index)
    (0..8).to_a.each_slice(3) do |row_range|
      if row_range.include? (row_index)
        (0..8).to_a.each_slice(3) do |col_range|
          if col_range.include? (column_index)
            block = []
            to_block = lambda {|range| block << @board[range][col_range[0]..col_range[2]]}
            to_block.call(row_range[0])
            to_block.call(row_range[1])
            to_block.call(row_range[2])
            return block.flatten!(1) || []
          end
        end
      end
    end
  end

  def collect_elements(cell_set)
    cell_set.each_with_object([]) do |cell, collection|
      collection << cell if cell.kind_of? yield
    end
  end

  def get_eliminations(cell_set)
    collect_elements(cell_set) {Integer}
  end

  def combine_eliminations(row_index, column_index)
    combined_eliminations = []
    combined_eliminations << get_eliminations(get_row(row_index))
    combined_eliminations << get_eliminations(get_column(column_index))
    combined_eliminations << get_eliminations(get_inner_block(row_index, column_index))
    combined_eliminations.flatten.uniq || []
  end


  def eliminate_cell_possibilities(cell, row_index, column_index)
    cell.each do |number|
      if combine_eliminations(row_index, column_index).include?(number)
        cell.delete(number)
      end
    end
  end

  def set_cell_value(cell, row, row_index, column_index)
    if cell.length == 1
      row.insert(column_index, cell[0])
      row.delete(cell)
    end
  end

  def check_if_value_set(cell_set, value)
    integers = collect_elements(cell_set) {Integer}
    !integers.include? value
  end


  def find_uniques(cell_set)
    possibilities = collect_elements(cell_set) {Array}
    frequencies = possibilities.flatten.group_by { |value| value }
    frequencies.select! {|key , value| value.length == 1}
    if !frequencies.empty? #if frequencies isn't empty
      frequencies.each do |key, value|
        cell_set.each_with_index do |cell, index|
          if (cell.kind_of? Array) && (cell.include? key) && check_if_value_set(cell_set, key)
            cell_set.insert(index, key)
            cell_set.delete(cell)
          end
        end
      end
    end
  end


  def board_to_s
    12.times do(print '_ ') end; puts " \n\n"
    @board.each_slice(3) do |row|
      row.each do |set|
        set.each_slice(3) {|slice| print slice.join(' ') + ' | ' }
        puts ''
      end
      12.times do (print '_ ') end; puts " \n\n"
    end
  end

end


board_string = File.readlines('sample.unsolved.txt')[12].chomp

game = Sudoku.new(board_string)
puts game.solve!
puts game.board_to_s
