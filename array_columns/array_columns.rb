#Experiment with putting array data into columns without wasted space.

class ColumnizedPage
  #Prepare a blank page.
  def initialize(page_length, page_width)
    @page_length, @page_width = page_length, page_width
    @page_data = []
  end

  #Add an item to this page.
  #<br>Returns
  #* The number if items that did not fit in the page.
  def add(raw_item)
    item = raw_item.to_s
    fail "Item too large to fit." unless item.length < @page_width

    if (slot = find_next_column)
      @page_data[slot] << item
    else
      @page_data << [item]
    end

    adjust_configuration
  end

  #Render the page as an array of strings.
  def render
    results = []
    widths  = @page_data.map {|column| column.column_width}

    (0...rows).each do |column_index|
      results << @page_data.each_with_index.map do |column, index|
        column[column_index].to_s.ljust(widths[index])
      end.join(" ")
    end

    @page_data = []
    results
  end

  private

  #Make sure the page fits within its boundaries.
  #<br>Returns
  #* The number if items that did not fit in the page.
  def adjust_configuration
    while total_width >= @page_width
      return @page_data.pop.length if rows == @page_length
      add_a_row
    end

    0
  end

  #Add a row to the page, moving items as needed.
  def add_a_row
    target = rows + 1
    pool, @page_data = @page_data.flatten, []

    until pool.empty?
      @page_data << pool.shift(target)
    end
  end

  #Compute the total width of all of the columns.
  #<br>Returns
  #* The sum of the widths of the widest items of each column plus a space
  #  between each of those columns.
  def total_width
    if empty?
      0
    else
      @page_data.inject(@page_data.length-1) do |sum, column|
        sum + column.column_width
      end
    end
  end

  #Does the data fit on the page?
  def fits?
    total_width < @page_width
  end

  #How many rows are currently in this page?
  def rows
    empty? ? 0 : @page_data[0].length
  end

  #Is this page empty?
  def empty?
    @page_data.empty?
  end

  #Which column will receive the next item?
  #<br>Returns
  #* The index of the first non-filled column or nil if none found.
  def find_next_column
    (1...(@page_data.length)).each do |index|
      if @page_data[index].length < @page_data[index-1].length
        return index
      end
    end

    nil
  end
end

class Array
  #Print out the array with efficient columns.
  def puts_columnized(page_length = 50, page_width = 80)
    columnize(page_length, page_width).each do |page|
      puts page
      puts
    end
  end

  #Convert the array to strings with efficient columns.
  #<br>
  #* An array of arrays of strings
  def columnize(page_length, page_width)
    index, pages, limit = 0, [], self.length
    builder = ColumnizedPage.new(page_length, page_width)

    while index < limit
      index += 1 - (left_over = builder.add(self[index]))
      pages << builder.render if (left_over > 0) || (index == limit)
    end

    pages
  end

  #Get the widest element of an array.
  def column_width
    (self.max_by {|item| item.length}).length
  end
end

#Build a sample array.
gen = Random.new
count = 1 + gen.rand(200) + gen.rand(200)
test_array = Array.new(count) do |i|
  i.to_s + ":" + "*" * (gen.rand(1..4) + gen.rand(4) * gen.rand(4))
end

#Display test_array in neat columns
test_array.puts_columnized(50)
