require 'test_helper'

class DateRangeTest < Minitest::Test
  def test_stores_the_initial_date
    date_range = DateRange.new initial: Date.today, final: Date.today.tomorrow
    assert_equal Date.today, date_range.initial
  end

  def test_stores_the_final_date
    date_range = DateRange.new initial: Date.today, final: Date.today.tomorrow
    assert_equal Date.today.tomorrow, date_range.final
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

  def test_an_excetion_is_raised_if_initial_or_final_is_not_set
    assert_raises do
      DateRange.new
    end

    assert_raises do
      DateRange.new initial: Date.today
    end

    assert_raises do
      DateRange.new final: Date.today
    end
  end

  def test_to_range_is_the_range_between_dates
    date_range = DateRange.new year: 2014
    assert_equal '2014-01-01'.to_date..'2014-12-31'.to_date, date_range.to_range

    date_range = DateRange.new year: 2015
    assert_equal '2015-01-01'.to_date..'2015-12-31'.to_date, date_range.to_range
  end

  def test_consistent_is_true_if_initial_is_before_final
    date_range = DateRange.new initial: Date.today, final: Date.today.tomorrow
    assert date_range.consistent?
  end

  def test_consistent_is_false_if_initial_is_after_final
    date_range = DateRange.new initial: Date.today, final: Date.today.yesterday
    refute date_range.consistent?
  end

  def test_includes_is_true_if_the_given_date_is_in_the_date_range
    date_range = DateRange.new initial: Date.today.yesterday, final: Date.today.tomorrow
    assert date_range.includes? Date.today
  end

  def test_includes_is_false_if_the_given_date_is_not_in_the_date_range
    date_range = DateRange.new initial: Date.today.yesterday, final: Date.today.tomorrow
    refute date_range.includes? 1.month.ago
  end
end
