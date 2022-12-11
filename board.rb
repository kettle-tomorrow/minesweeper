class Board
  attr_reader :rows

  def initialize(mines:)
    row1 = [{ display: "■", arround_mine_number: 0, is_mine: false }, { display: "■", arround_mine_number: 0, is_mine: false }, { display: "■", arround_mine_number: 0, is_mine: false }]
    row2 = [{ display: "■", arround_mine_number: 0, is_mine: false }, { display: "■", arround_mine_number: 0, is_mine: false }, { display: "■", arround_mine_number: 0, is_mine: false }]
    row3 = [{ display: "■", arround_mine_number: 0, is_mine: false }, { display: "■", arround_mine_number: 0, is_mine: false }, { display: "■", arround_mine_number: 0, is_mine: false }]
    @rows = [row1, row2, row3]

    mines.each { |mine| set_mine(mine) }

    @row_min = 0
    @row_max = @rows.size - 1
    @squire_min = 0
    @squire_max = @rows.first.size - 1

    set_arround_mine_numbers
  end

  def current_board
    @rows.map { |row| row.map { |squire| squire[:display] }.join(" ") }
  end

  def mine?(row_number:, squire_number:)
    @rows[row_number][squire_number][:is_mine] == true
  end

  def open(row_number:, squire_number:)
    @rows[row_number][squire_number][:display] = @rows[row_number][squire_number][:arround_mine_number]
  end

  def completed?
    @rows.all? do |row|
      row.all? do |squire|
        squire[:display] != "■" || squire[:is_mine] == true
      end
    end
  end

  def completed_board
    @rows.map { |row| row.map { |squire| squire[:is_mine] == true ? "✖" : squire[:display] }.join(" ") }
  end

  private

  def set_mine(mine)
    @rows[mine[0]][mine[1]][:is_mine] = true
  end

  def set_arround_mine_numbers
    (@row_min..@row_max).each do |i|
      (@squire_min..@squire_max).each do |j|
        if @rows[i][j][:is_mine] == false
          top = i - 1
          down = i + 1
          left = j - 1
          right = j + 1
          if top >= @row_min
            @rows[i][j][:arround_mine_number] += 1 if @rows[top][j][:is_mine] == true
          end
          if down <= @row_max
             @rows[i][j][:arround_mine_number] += 1 if @rows[down][j][:is_mine] == true
          end
          if left >= @squire_min
            @rows[i][j][:arround_mine_number] += 1 if @rows[i][left][:is_mine] == true
          end
          if right <= @squire_max
            @rows[i][j][:arround_mine_number] += 1 if @rows[i][right][:is_mine] == true
          end
          top_left = [top, left]
          top_right = [top, right]
          down_left = [down, left]
          down_right = [down, right]
          if top_left[0] >= @row_min && top_left[1] >= @squire_min
            @rows[i][j][:arround_mine_number] += 1 if @rows[top_left[0]][top_left[1]][:is_mine] == true
          end
          if top_right[0] >= @row_min && top_right[1] <= @squire_max
            @rows[i][j][:arround_mine_number] += 1 if @rows[top_right[0]][top_right[1]][:is_mine] == true
          end
          if down_left[0] <= @row_max && down_left[1] >= @squire_min
            @rows[i][j][:arround_mine_number] += 1 if @rows[down_left[0]][down_left[1]][:is_mine] == true
          end
          if down_right[0] <= @row_max && down_right[1] <= @squire_max
            @rows[i][j][:arround_mine_number] += 1 if @rows[down_right[0]][down_right[1]][:is_mine] == true
          end
        end
      end
    end
  end
end
