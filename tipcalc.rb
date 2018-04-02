class BankAccount
  @@minimum_balance = 200
  attr_accessor :balance
  def initialize(amount, name)
    @balance = amount
    @name = name
    opening_balance
  end

  def deposit(amount)
    @balance += amount
  end

  def withdraw(amount)
    @balance -= amount
  end

  def transfer(amount, other_account)
    self.balance -= amount
    other_account.balance += amount
  end

  def self.minimum_balance
    @@minimum_balance
  end

  def self.minimum_balance=(value)
    @@minimum_balance = value
  end

  def opening_balance
    if @balance < BankAccount.minimum_balance
      raise ArgumentError.new(“raises an error if opening balance is too low”)
    end
  end
  # def self.minimum_balance
  #   if @balance >= 200
  #     dont raise_error
  #
  #     def bankAccount.minimum_balance
  #       end
  #
  #   end
  # end
end
