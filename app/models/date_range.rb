class DateRange
  attr_reader :initial, :final, :year

  def initialize(initial: nil, final: nil, year: nil)
    if year
      @year = year
      calculate_initial_and_final_dates
    else
      raise unless initial and final
      @initial = initial
      @final = final
    end
  end

  def to_range
    @initial..@final
  end

  def consistent?
    @initial < @final
  end

  def includes?(date)
    to_range.cover? date
  end

private

  def calculate_initial_and_final_dates
    @initial = Date.new(@year).beginning_of_year
    @final = Date.new(@year).end_of_year
  end
end
