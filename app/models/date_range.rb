class DateRange
  attr_reader :initial, :final, :year

  def initialize(initial: nil, final: nil, year: nil)
    @year = year
    @initial = initial
    @final = final
    calculate_initial_and_final_dates if @year
  end

  def to_range
    @initial..@final
  end

private

  def calculate_initial_and_final_dates
    @initial = Date.new(@year).beginning_of_year
    @final = Date.new(@year).end_of_year
  end
end
