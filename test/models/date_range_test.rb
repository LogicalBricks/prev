require 'test_helper'

class DateRangeTest < Minitest::Test
  def test_stores_the_initial_date
    date_range = DateRange.new initial: Date.today
    assert_equal Date.today, date_range.initial
  end

  def test_stores_the_final_date
    date_range = DateRange.new final: Date.today
    assert_equal Date.today, date_range.final
  end

  def test_stores_the_year
    date_range = DateRange.new year: 2015
    assert_equal 2015, date_range.year
  end

  def test_calculates_the_initial_and_final_dates_when_receives_year
    date_range = DateRange.new year: 2015
    assert_equal '2015-01-01'.to_date, date_range.initial
    assert_equal '2015-12-31'.to_date, date_range.final

    date_range = DateRange.new year: 2014
    assert_equal '2014-01-01'.to_date, date_range.initial
    assert_equal '2014-12-31'.to_date, date_range.final
  end

  def test_to_range_is_the_range_between_dates
    date_range = DateRange.new year: 2014
    assert_equal '2014-01-01'.to_date..'2014-12-31'.to_date, date_range.to_range

    date_range = DateRange.new year: 2015
    assert_equal '2015-01-01'.to_date..'2015-12-31'.to_date, date_range.to_range
  end
end
