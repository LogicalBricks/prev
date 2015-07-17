# Public: Utility class to generate and validate a range of dates. It receives
# an initial and final date or just a year. If two values are provided, they
# will be used as initial and final date. If just one value is provided, it
# will be used as year. The initial and final dates should be kind of `Date` or
# respond to `to_date` method. The year value should be an integer or a string.
#
# Examples:
#
#   date_range = DateRange.new Date.today.yesterday, Date.today.tomorrow
#   date_range.includes?(Date.today)
#   # => true
class DateRange
  attr_reader :initial, :final, :year

  # Public: Initialize a DateRange.
  #
  # Examples:
  #
  # date_range = DateRange.new Date.today, Date.today.tomorrow
  # date_range = DateRange.new "2013-04-23", "2016-11-03"
  # date_range = DateRange.new 2015
  # date_range = DateRange.new "2016"
  #
  # initial_or_year - A date or a value that can be converted through the
  #                   `to_date` method indicating the initial date. A String or
  #                   Integer indicating year.
  # final           - A date or a value that can be converted through the
  #                   `to_date` method indicating the final date.
  def initialize(initial_or_year, final=nil)
    if initial_or_year and final
      @initial = initial_or_year.to_date
      @final = final.to_date
    else
      raise "Invalid type for year, it must be integer or string" unless valid_type_for_year?(initial_or_year)
      @year = initial_or_year.to_i
      calculate_initial_and_final_dates
    end
  end

  # Public: Returns the initial and final dates as a range.
  #
  # Examples
  #
  #   date_range = DateRange.new 2016
  #   date_range.to_range
  #   # => '2016-01-01'.to_date..'2016-12-31'.to_date
  def to_range
    @initial..@final
  end

  # Public: Returns true if the initial date is before the final date. Return
  # false otherwise.
  #
  # Examples
  #
  #  date_range = DateRange.new Date.today, Date.today.tomorrow
  #  date_range.consistent?
  #  # => true
  #
  #  date_range = DateRange.new Date.today, Date.today.yesterday
  #  date_range.consistent?
  #  # => false
  def consistent?
    @initial < @final
  end

  # Public: Returns true if the given date is in between the initial and final
  # dates.
  #
  # Examples
  #
  #  date_range = DateRange.new Date.today.yesterday, Date.today.tomorrow
  #  date_range.includes? Date.today
  #  # => true
  #
  #  date_range = DateRange.new Date.today.yesterday, Date.today.tomorrow
  #  date_range.includes? 1.month.ago
  #  # => false
  def includes?(date)
    to_range.cover? date
  end

private

  def calculate_initial_and_final_dates
    @initial = Date.new(@year).beginning_of_year
    @final = Date.new(@year).end_of_year
  end

  def valid_type_for_year?(year)
    year.kind_of?(Integer) or year.kind_of?(String)
  end
end
