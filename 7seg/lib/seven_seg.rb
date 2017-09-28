class SevenSeg
  def initialize(num)
    @num = num.to_s
    @top_line = []
    @middle_line = []
    @bottom_line = []
  end

  def printify(width = 1, height = 1)
    @num.each_char {|n|
      logicalise(n)
    }
    middle_lines = []
    bottom_lines = []
    top_line = sort_top(width)
    h = height
    height.times {
      middle_lines << sort_middle(width, h)
      bottom_lines << sort_bottom(width, h)
      h -= 1
     }
     p top_line.join
     middle_lines.each{ |m|
       p m.join
     }
     bottom_lines.each{ |b|
       p b.join
     }
     [top_line.join,middle_lines.join,bottom_lines.join].join("\n")
  end

  def sort_top(width)
    top_line_arr = []
    @top_line.each_slice(3) do |n|
      top_line_arr  << " "
      if n[1]
        top_line_arr  << "_" * width
      else
        top_line_arr  << " " *  width
      end
      top_line_arr  << " "
    end
    top_line_arr
  end
  def sort_middle(width, height)
    middle_line_arr = []
    @middle_line.each_slice(3) do |n|
      if n[0]
        middle_line_arr << "|"
      else
        middle_line_arr << " "
      end
      if n[1] && height == 1
         middle_line_arr << "_" * width
      else
         middle_line_arr << " " * width
      end
      if n[2]
        middle_line_arr << "|"
      else
        middle_line_arr << " "
      end
    end
    middle_line_arr
  end
  def sort_bottom(width, height)
    bottom_line_arr = []
    @bottom_line.each_slice(3) do |n|
      if n[0]
         bottom_line_arr << "|"
      else
         bottom_line_arr << " "
      end
      if n[1] && height == 1
        bottom_line_arr << "_" * width
      else
        bottom_line_arr << " " * width
      end
      if n[2]
        bottom_line_arr << "|"
      else
        bottom_line_arr << " "
      end
    end
    bottom_line_arr
  end
  def logicalise(digit)
    case digit
    when '0'
      truthtable = [false,true,false,true,false,true,true,true,true]
    when '1'
      truthtable = [false,false,false,false,false,true,false,false,true]
    when '2'
      truthtable = [false,true,false,false,true,true,true,true,false]
    when '3'
      truthtable = [false,true,false,false,true,true,false,true,true]
    when '4'
      truthtable = [false,false,false,true,true,true,false,false,true]
    when '5'
      truthtable = [false,true,false,true,true,false,false,true,true]
    when '6'
      truthtable = [false,true,false,true,true,false,true,true,true]
    when '7'
      truthtable = [false,true,false,false,false,true,false,false,true]
    when '8'
      truthtable = [false,true,false,true,true,true,true,true,true]
    when '9'
      truthtable = [false,true,false,true,true,true,false,true,true]
    end
    (0..2).to_a.each do |n|
      @top_line << truthtable[n]
    end
    (3..5).to_a.each do |n|
      @middle_line << truthtable[n]
    end
    (6..8).to_a.each do |n|
      @bottom_line << truthtable[n]
    end
  end
end
