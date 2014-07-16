#require 'pry'
#require 'pry-nav'


class Object
  def deep_clone
    return @deep_cloning_obj if @deep_cloning
    @deep_cloning_obj = clone
    @deep_cloning_obj.instance_variables.each do |var|
      val = @deep_cloning_obj.instance_variable_get(var)
      begin
        @deep_cloning = true
        val = val.deep_clone
      rescue TypeError
        next
      ensure
        @deep_cloning = false
      end
      @deep_cloning_obj.instance_variable_set(var, val)
    end
    deep_cloning_obj = @deep_cloning_obj
    @deep_cloning_obj = nil
    deep_cloning_obj
  end
end



class Sudoku
  attr_accessor :full_board
   def initialize(board_string)
    @board_string = board_string.to_s.split("")
    @full_board = (0..2).map { |tri_square|
      (0..2).map {|square|
        (0..2).map {|tri_cell|
          (0..2).map {|cell|
            digit = @board_string[tri_square*27 + square*3 + tri_cell*9 +cell]
           Cell.new(digit, tri_square, square, tri_cell, cell)
          }
        }
      }
    }
  end

  def loop_square(tri_square, square)
    (0..2).each{|tri_cell|
      (0..2).each{|cell|
        yield @full_board[tri_square][square][tri_cell][cell]
      }
    }
  end

  def loop_row(tri_square, tri_cell)
    (0..2).each{|square|
      (0..2).each{|cell|
         yield @full_board[tri_square][square][tri_cell][cell]
      }
    }
  end

  def loop_column(square, cell)
    (0..2).each{|tri_square|
      (0..2).each{|tri_cell|
         yield @full_board[tri_square][square][tri_cell][cell]
      }
    }
  end

  def loop_board
    (0..2).each{|tri_square|
      (0..2).each{|tri_cell|
        loop_row(tri_square,tri_cell){|cell|yield cell}
      }
    }
  end

  def solve!

   until finished?
    begin
      something_changed = false
      something_changed = standard_method || elimination_method
    end while something_changed


    if has_mistakes?
      return false
    elsif !finished?
      return guessing_method
    end
   end
   return self
  end

  def has_mistakes?
    mistakes = false
    loop_board{|cell|
      mistakes = true if cell.solution == " " && cell.possibilities == []
    }
    #puts "has mistakes: #{mistakes}"

    mistakes
  end


  def finished?
    finished = true
    loop_board{|cell|
      finished = false if cell.solution == " "
    }
    finished
  end


def standard_method
  begin
    something_changed = false
    loop_board do |cell|
      to_delete=[]
      cell.possibilities.each do |possibility|
        loop_row(cell.tri_square_index, cell.tri_cell_index) do |row_cell|
            if row_cell.solution == possibility
              to_delete << possibility
              something_changed = true
            end
        end
        loop_column(cell.square_index, cell.cell_index) do |column_cell|
              if column_cell.solution == possibility
                to_delete << possibility
                something_changed = true
            end
        end
        loop_square(cell.tri_square_index, cell.square_index) do |square_cell|
              if square_cell.solution == possibility
                to_delete << possibility
                something_changed = true
            end
        end
      end
      to_delete.each{|non_possibility| cell.possibilities.delete(non_possibility)}
      if cell.possibilities.length == 1
        cell.solution = cell.possibilities[0]
        cell.possibilities = []
      end
    end
  end while something_changed
  return something_changed
end


  def elimination_method

    #begin
      something_changed = false
      loop_board { |cell|
          cell.possibilities.each { |possibility|


            elimination_method_valid = true
 


            loop_row(cell.tri_square_index, cell.tri_cell_index) { |row_cell|
              unless row_cell === cell 
                if row_cell.possibilities.include? possibility            
                  elimination_method_valid = false
                end
              end
            }
            if elimination_method_valid
              cell.solution = possibility
              cell.possibilities = [possibility]
              something_changed = true
            end
            elimination_method_valid = true
            loop_column(cell.square_index, cell.cell_index) { |row_cell|
              unless row_cell === cell 
                if row_cell.possibilities.include? possibility            
                  elimination_method_valid = false
                end
              end
            }
            if elimination_method_valid
              cell.solution = possibility
              cell.possibilities = [possibility]
              something_changed = true
            end
            elimination_method_valid = true
            loop_square(cell.tri_square_index, cell.square_index) { |row_cell|
              unless row_cell === cell 
                if row_cell.possibilities.include? possibility            
                  elimination_method_valid = false
                end
              end
            }
            if elimination_method_valid
              cell.solution = possibility
              cell.possibilities = [possibility]
              something_changed = true
            end

          }


           # cell.solution = cell.possibilities[0] if cell.possibilities.length == 1
        }



    #end while something_changed
    return something_changed
  end





  def guessing_method
        #puts "hello"

        smallest_num_of_possibilities = 9
        loop_board{|cell|
          smallest_num_of_possibilities = cell.possibilities.length if cell.possibilities.length < smallest_num_of_possibilities && cell.solution == " "
          #puts "#{smallest_num_of_possibilities} , #{cell.inspect}"
        }

        loop_board{|cell|
          if cell.possibilities.length == smallest_num_of_possibilities
            cell.possibilities.each_with_index{|guess_value, guess_index|

             guessing_board_copy = Marshal.load(Marshal.dump(self))
             guessing_board_copy.full_board[cell.tri_square_index][cell.square_index][cell.tri_cell_index][cell.cell_index].solution = guess_value
             guessing_board_copy.full_board[cell.tri_square_index][cell.square_index][cell.tri_cell_index][cell.cell_index].possibilities = []
             #puts "here5 #{guessing_board_copy.full_board[cell.tri_square_index][cell.square_index][cell.tri_cell_index][cell.cell_index].inspect}"

            if guessing_board_copy.solve!

              # puts guessing_board_copy.print_board
              self.full_board = guessing_board_copy.full_board
              return guessing_board_copy
            end 

              }




            # if !guessing_board_copy.solve!
            #   puts guessing_board_copy.print_board
            #   break
            # else
            #   puts guessing_board_copy.print_board
            # end       
             return false #guessing_board_copy.solve!

            # return guessing_board_copy if !has_mistakes?
          end
        }

    #only make one guess and then continue the normal way (and guess on one where the possibilities are only 2)
    #find a way to save state before the guess.
  end

  def print_board
    i = 0
    a = 1
    loop_board do |cell|
      if i % 9 == 0
        print "\n  ------------------------------------------------------| \n  |  #{cell.solution}  |"
      elsif a % 3 == 0
        print "  #{cell.solution}  |"
      else
        print "  #{cell.solution}  |"
      end
      i+=1
      a+=1
    end
    print "\n  ------------------------------------------------------"
  end
end



class Cell
  attr_accessor :solution, :possibilities
  attr_reader :tri_square_index, :tri_cell_index, :square_index, :cell_index
  def initialize(string, tri_square, square, tri_cell, cell)

    @possibilities = ["1","9","3","4","5","6","7","8","2"]
    @tri_square_index = tri_square
    @tri_cell_index = tri_cell
    @square_index = square
    @cell_index = cell

    if string.to_i == 0
      @solution = " "
    else
      @solution = string
      @possibilities = [string]
    end
  end
  def solved?
    if @possibilities.length <= 1
      @solution = @possibilities
    end
  end
end

