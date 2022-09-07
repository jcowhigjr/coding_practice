module Test
  # def initialize; end

  class Sale
    attr_reader :answer, :buyers, :balance
    PRICE = 25
    def initialize(buyers = [])
      raise StandardError, "need array of buyers bills" if buyers.empty?
      @buyers = buyers
      @balance = 0
    end

    def sale_service
      @buyers.each do |bill|
        return false unless can_make_change?(bill: bill)
        checkout
      end
    end

    def will_perform_sale
      @answer = sale_service ? "YES" : "NO"
    end

    private

    def can_make_change?(bill:, balance: @balance)
      price = 25
      return false if bill.nil?
      change_owed = bill - price
      return false if balance < change_owed
      true if make_change(bill: bill) >= 0
    end

    def checkout
      @balance += 25
    end

    def make_change(bill:, price: PRICE)
      bill - price
    end
  end
end
