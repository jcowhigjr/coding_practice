module Test
  class Bill
    attr_reader :value

    def initialize(denomination:)
      @denomination = denomination
      @value = _value
    end

    # a setter method to return a new value object
    def value=(denomination:)
      Bill.new(denomination: denomination)
    end

    private

    # a getter method to return a value object
    def _value
      case @denomination
      when "twenty_five"
        @value = 25
      when "fifty"
        @value = 50
      when "one_hundred"
        @value = 100
      end
    end
  end

  class Till
    attr_reader :denomination, :quantity
    def initialize(denomination:)
      @bill = Bill.new(denomination: denomination)
      @quantity = 1
      @value = _value
    end

    # increment quantity
    def increment
      @quantity = _quantity.next
    end

    def decrement
      @quantity = _quantity.pred if _quantity > 0
    end

    def value
      _value
    end

    private

    def _quantity
      @quantity
    end

    # a getter method to return a value object
    def _value
      @bill.value * @quantity
    end
  end

  class Sale
    attr_reader :answer, :buyers, :balance
    PRICE = 25

    def initialize(buyers = [])
      @twenty_fives = Till.new denomination: "twenty_five"
      @fifties = Till.new denomination: "fifty"
      @one_hundreds = Till.new denomination: "one_hundred"
      raise StandardError, "need array of buyers bills" if buyers.empty?
      @buyers = buyers
      @balance = 0
      @bank = {@twenty_fives => 0, @fifties => 0, @one_hundreds => 0}
    end

    def increment_till(bill:)
      case bill
      when 25
        @twenty_fives.increment
      when 50
        @fifties.increment
      when 100
        @one_hundreds.increment
      end
    end

    def decrement_till(bill:)
      case bill
      when 25
        @twenty_fives.decrement
      when 50
        @fifties.decrement
      when 100
        @one_hundreds.decrement
      end
    end

    def sale_service
      @buyers.each do |bill|
        return false unless can_make_change?(bill: bill)
        increment_till(bill: bill)
        checkout
      end
    end

    def will_perform_sale
      @answer = sale_service ? "YES" : "NO"
    end

    private

    def convert_bill_to_till(bill:)
      case bill
      when 25
        @twenty_fives
      when 50
        @fifties
      when 100
        @one_hundreds
      end
    end

    def change_owed(bill:, price: PRICE)
      till = convert_bill_to_till bill: bill
      tender = till.value if till.is_a?(Till)
      tender - price
    end

    def can_make_change?(bill:, balance: @balance, till: @till)
      return false if bill.nil?
      change_owed = change_owed(bill: bill)
      return false if balance < change_owed
      true if make_change(bill: bill) >= 0
    end

    def checkout
      @balance += PRICE
    end

    def make_change(bill:, price: PRICE)
      bill - price
    end
  end
end
