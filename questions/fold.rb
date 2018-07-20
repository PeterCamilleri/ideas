

class Array

  def fold_into_hash(values)
    result = {}

    self.each_with_index do |key, index|
      result[key] = values[index]
    end

    result
  end

end

month_day_year = [:month, :day, :year]

#...

puts month_day_year.fold_into_hash(["12", "21", "1985"])

