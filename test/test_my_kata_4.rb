require_relative "test_helper"
require "minitest/autorun"
require "my_kata_4"

class MoneyTest < ActiveSupport::TestCase
  include Test
  # Money takes a denomination and returns a value
  test "money takes a denomination and returns a value" do
    assert_equal 25, Bill.new(denomination: "twenty_five").value
    assert_equal 50, Bill.new(denomination: "fifty").value
    assert_equal 100, Bill.new(denomination: "one_hundred").value
  end
end

class TillTest < ActiveSupport::TestCase
  include Test
  # Money takes a denomination and returns a value
  test "money takes a denomination and returns a value" do
    assert_equal 25, Till.new(denomination: "twenty_five").value
    assert_equal 50, Till.new(denomination: "fifty").value
    assert_equal 100, Till.new(denomination: "one_hundred").value
  end

  test "till can increment quantity" do
    @twenty_fives = Till.new(denomination: "twenty_five")
    assert_equal 25, @twenty_fives.value
    assert_equal 1, @twenty_fives.quantity
    @twenty_fives.increment
    assert_equal 2, @twenty_fives.quantity
    assert_equal 50, @twenty_fives.value
  end

  test "till can decrement quantity" do
    @twenty_fives = Till.new(denomination: "twenty_five")
    assert_equal 25, @twenty_fives.value
    assert_equal 1, @twenty_fives.quantity
    @twenty_fives.decrement
    assert_equal 0, @twenty_fives.quantity
    assert_equal 0, @twenty_fives.value
    @twenty_fives.decrement
    assert_equal 0, @twenty_fives.quantity
    assert_equal 0, @twenty_fives.value
  end
end

class SaleTest < ActiveSupport::TestCase
  include Test
  # Vasya is currently working as a clerk. He wants to sell a ticket to every single person in this line. Each of them has a single 100, 50 or 25 dollars bill. A ticket costs 25 dollars.

  # Can Vasya sell a ticket to each person and give the change if he initially has no money and sells the tickets strictly in the order people follow in the line?

  # Return YES, if Vasya can sell a ticket to each person and give the change with the bills he has at hand at that moment. Otherwise return NO.

  # Examples;

  # tickets([25, 25, 50]) // => YES

  # tickets([25, 100]) // => NO

  # correct_change?(till: { 25 => 0, 50 => 1, 100 => 0}, price: 25, bill: 50,  change: 25) // => false
  # tickets([25, 50, 50]) // => NO

  test "Sale instance takes an ordered array of bills" do
    assert_raises(StandardError) { Sale.new }
    assert Sale.new([25, 25, 50])
  end

  setup do
    @sale = Sale.new([25, 25, 50])
  end

  test "can_make_change? knows balance accepts a single bill" do
    assert @sale.send(:can_make_change?, bill: 25)
  end

  test "can_make_change? can take a balance and a bill" do
    assert @sale.send(:can_make_change?, bill: 25, balance: 25)
    refute @sale.send(:can_make_change?, bill: 50, balance: 0)
  end

  test "checkout adds 25 to balance returns success" do
    assert @sale.send(:checkout)
    assert_equal 25, @sale.balance
  end

  test "mock sale_service" do
    assert @sale.send(:sale_service)
  end

  test "collect balances" do
    @sale = Sale.new([25, 25, 50, 50, 100])
    assert_equal [25, 50, 75, 100, 125], @sale.buyers.map { |bill| @sale.send(:checkout) }
  end

  test "collect change" do
    @sale = Sale.new([25, 25, 50, 50, 100])
    @balances = @sale.buyers.map { |bill| @sale.send(:checkout) }
    assert_equal [0, 0, 25, 25, 75], @sale.buyers.map { |bill| @sale.send(:make_change, bill: bill) }
  end

  test "can_make_change? with balance" do
    @sale = Sale.new([25, 25, 50, 50, 100])
    @balances = @sale.buyers.map { |bill| @sale.send(:checkout) }
    assert_equal [true, true, true, true, true], @sale.buyers.map { |bill| @sale.send(:can_make_change?, bill: bill, balance: @balances.shift) }
  end

  test "can_make_change? with balance and change" do
    @sale = Sale.new([25, 25, 50, 50, 100])
    @balances = @sale.buyers.map { |bill| @sale.send(:checkout) }
    assert_equal [0, 0, 25, 25, 75], @sale.buyers.map { |bill| @sale.send(:make_change, bill: bill) }
    assert_equal [true, true, true, true, true], @sale.buyers.map { |bill| @sale.send(:can_make_change?, bill: bill, balance: @balances.shift) }
  end

  test "sale_service" do
    @sale = Sale.new([25, 25, 50, 50, 100])
    assert @sale.send(:sale_service)
  end

  test "sale_service with NO" do
    @sale = Sale.new([25, 100])
    refute @sale.send(:sale_service)
  end

  test "sale_service with 3 buyers but incorrect change NO" do
    @sale = Sale.new([25, 50, 50])
    # skip "till not implemented"
    refute @sale.send(:sale_service)
  end

  test "will_perform_sale" do
    assert_equal "YES", @sale.will_perform_sale
  end

  test "will_perform_sale returns NO" do
    @sale = Sale.new([25, 100])
    assert_equal "NO", @sale.will_perform_sale
  end

  test "will_perform_sale with 4 buyers returns YES" do
    @sale = Sale.new([25, 25, 25, 100])
    assert_equal "YES", @sale.will_perform_sale
  end

  test "will_perform_sale with 3 buyers returns NO" do
    @sale = Sale.new([25, 25, 100])
    assert_equal "NO", @sale.will_perform_sale
  end

  test "will_perform_sale with 4 buyers returns NO" do
    @sale = Sale.new([25, 25, 100, 100])
    assert_equal "NO", @sale.will_perform_sale
  end
end
