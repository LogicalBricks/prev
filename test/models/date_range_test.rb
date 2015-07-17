require 'test_helper'

class DateRangeTest < Minitest::Test
  def test_stores_the_initial_date
    date_range = DateRange.new Date.today, Date.today.tomorrow
    assert_equal Date.today, date_range.initial
  end

  def test_stores_the_final_date
    date_range = DateRange.new Date.today, Date.today.tomorrow
    assert_equal Date.today.tomorrow, date_range.final
  end

  def test_stores_the_year
    date_range = DateRange.new 2015
    assert_equal 2015, date_range.year
  end

  def test_receives_the_initial_and_final_date_as_strings
    date_range = DateRange.new "2013-04-23", "2016-11-03"
    assert_equal "2013-04-23".to_date, date_range.initial
    assert_equal "2016-11-03".to_date, date_range.final
  end

  def test_receives_the_year_as_string
    date_range = DateRange.new "2016"
    assert_equal 2016, date_range.year
  end

  def test_calculates_the_initial_and_final_dates_when_receives_only_year
    date_range = DateRange.new 2015
    assert_equal '2015-01-01'.to_date, date_range.initial
    assert_equal '2015-12-31'.to_date, date_range.final

    date_range = DateRange.new "2014"
    assert_equal '2014-01-01'.to_date, date_range.initial
    assert_equal '2014-12-31'.to_date, date_range.final
  end

  def test_an_excetion_is_raised_if_no_param_is_given
    assert_raises do
      DateRange.new
    end
  end

  def test_an_exception_is_raised_if_year_is_not_integer_or_string
    assert_raises do
      DateRange.new Date.today
    end

    assert_raises do
      DateRange.new 2011.4
    end

    assert_raises do
      DateRange.new 2011..2014
    end
  end

  def test_to_range_is_the_range_between_dates
    date_range = DateRange.new 2016
    assert_equal '2016-01-01'.to_date..'2016-12-31'.to_date, date_range.to_range

    date_range = DateRange.new "2015"
    assert_equal '2015-01-01'.to_date..'2015-12-31'.to_date, date_range.to_range
  end

  def test_consistent_is_true_if_initial_is_before_final
    date_range = DateRange.new Date.today, Date.today.tomorrow
    assert date_range.consistent?
  end

  def test_consistent_is_false_if_initial_is_after_final
    date_range = DateRange.new Date.today, Date.today.yesterday
    refute date_range.consistent?
  end

  def test_includes_is_true_if_the_given_date_is_in_the_date_range
    date_range = DateRange.new Date.today.yesterday, Date.today.tomorrow
    assert date_range.includes? Date.today
  end

  def test_includes_is_false_if_the_given_date_is_not_in_the_date_range
    date_range = DateRange.new Date.today.yesterday, Date.today.tomorrow
    refute date_range.includes? 1.month.ago
  end
end
