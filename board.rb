class Board
  attr_reader :squires

  def initialize(mine_count:, row_count:, column_count:)
    @row_min = 0
    @row_max = row_count - 1
    @column_min = 0
    @column_max = column_count - 1
    @mine_count = mine_count
    @squires = default_squires

    set_mines
    set_arround_mine_numbers
  end

  def current_board
    @squires.map { |row| row.map { |squire| squire[:display] }.join(" ") }
  end

  def mine?(row_number:, column_number:)
    @squires[row_number][column_number][:is_mine] == true
  end

  def open(row_number:, column_number:)
    @squires[row_number][column_number][:display] = @squires[row_number][column_number][:arround_mine_number]
  end

  def completed?
    @squires.all? do |row|
      row.all? do |squire|
        squire[:display] != "■" || squire[:is_mine] == true
      end
    end
  end

  def completed_board
    @squires.map { |row| row.map { |squire| squire[:is_mine] == true ? "✖" : squire[:display] }.join(" ") }
  end

  private

  def default_squires
    (0..@row_max).map do
      (0..@column_max).map do
        {
          display: "■",
          arround_mine_number: 0,
          is_mine: false
        }
      end
    end
  end

  def set_mines
    mines = Mines.generate(mine_count: @mine_count, row_max: @row_max, column_max: @column_max)
    mines.each { |mine| @squires[mine[0]][mine[1]][:is_mine] = true }
  end

  def set_arround_mine_numbers
    (@row_min..@row_max).each do |i|
      (@column_min..@column_max).each do |j|
        if @squires[i][j][:is_mine] == false
          top = i - 1
          down = i + 1
          left = j - 1
          right = j + 1
          if top >= @row_min
            @squires[i][j][:arround_mine_number] += 1 if @squires[top][j][:is_mine] == true
          end
          if down <= @row_max
             @squires[i][j][:arround_mine_number] += 1 if @squires[down][j][:is_mine] == true
          end
          if left >= @column_min
            @squires[i][j][:arround_mine_number] += 1 if @squires[i][left][:is_mine] == true
          end
          if right <= @column_max
            @squires[i][j][:arround_mine_number] += 1 if @squires[i][right][:is_mine] == true
          end
          top_left = [top, left]
          top_right = [top, right]
          down_left = [down, left]
          down_right = [down, right]
          if top_left[0] >= @row_min && top_left[1] >= @column_min
            @squires[i][j][:arround_mine_number] += 1 if @squires[top_left[0]][top_left[1]][:is_mine] == true
          end
          if top_right[0] >= @row_min && top_right[1] <= @column_max
            @squires[i][j][:arround_mine_number] += 1 if @squires[top_right[0]][top_right[1]][:is_mine] == true
          end
          if down_left[0] <= @row_max && down_left[1] >= @column_min
            @squires[i][j][:arround_mine_number] += 1 if @squires[down_left[0]][down_left[1]][:is_mine] == true
          end
          if down_right[0] <= @row_max && down_right[1] <= @column_max
            @squires[i][j][:arround_mine_number] += 1 if @squires[down_right[0]][down_right[1]][:is_mine] == true
          end
        end
      end
    end
  end
end
