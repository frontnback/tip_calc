# tip calc shit

 require 'colorize'
class Person
    attr_accessor :info

    def initialize(info={})
        @info = info
    end

    def change_info(info={})
        self.info = info
    end

    def full_name
        full_name =info[:first_name]
    if !@middle_name.nil?
        full_name += info[:last_name]
    end

end

module Transaction
    #contains all the operation need to manage a bank
    def balance
        # return balance  for each new object
        puts"-----------------------------------"
        puts"      Accounts balance - #{@account_number}"
        puts"-----------------------------------"
        puts "Your actual balance is $#{info[:balance]}"
        puts"-----------------------------------"
    end

    def deposit(amount)
        #add amount to the balance and return the aggregated amount
        depo_trans = @info[:balance] += amount
        @deposit.push(depo_trans)
    end

    def withdrawal(amount)
        depo_withdrawal = @info[:balance] -= amount
        @withdrawal.push(amount)
    end

    def transac_info
        count = 0
        transac_counter = count += 1
        puts"--------------------------------"
        puts"  Transaction Lists-#{@info[:first_name]}        "
        puts"---------------------------------"
        puts "Debit   |  Credit  |  No-Trans  "
        puts"-----------Deposit---------------"
        all=@deposit.each{|trans| puts "$#{trans}"}
        puts"Total deposit"
        total=all.sum
        puts"$#{total}"
        puts"-------------withdrawal----------"
        less=@withdrawal.each{|withd| puts "$#{withd}"}
        diff =less.sum
        puts "Total withdrawal"
        puts"$#{diff}"
        puts"-----------Bank Balance----------"
        bank_bal = total + diff
        puts "$#{bank_bal}"
    end


    def transfer( account_number,pin, amount)
        origin = @info[:balance]
        lists=BankAccount.account_list
        lists.each do |list|
            if account_number == list[:account_number] && list[:pin] == pin
                if amount > origin
                    puts "Low balance "
                    exit
                else origin > amount
                    trans = list[:balance] += amount
                    @deposit.push(amount)
                    self.withdrawal(amount)
                    puts"Transfer complete"
                end
            end
        end
    end

end

module Run
    include Transaction
    loop do
        puts"-----------------------------------"
        puts"   Welcome to Bank of Trust        ".blue
        puts"-----------------------------------"
        puts"\n"
        puts"--------------Menu-----------------"
        puts"1)Open an Account"
        puts"2)View Balance "
        puts"3)Make Transaction"
        puts"4)View Transaction"
        puts"5)Change Pin"
        puts"6)Exit"
        puts"-----------------------------------"
        puts"\n"
        puts"Choose from the menu above:".red
        ans = gets.chomp.to_i
            if (1..6).include?(ans)
            else
                puts"Incorrect selection"
                break
            end

        case ans
        when 1
            info = {}
            puts"\n"
            puts"-----------------------------------"
            puts"Let's gets started".yellow
            puts"-----------------------------------"
            puts"   Account Opening Questions       ".blue
            puts"-----------------------------------"
            puts"-----------------------------------"
            puts"What is your first name?:".yellow
                first_name = gets.chomp
                info[:first_name] = first_name
            puts"-----------------------------------"
            puts"What is your last name? :".yellow
                last_name = gets.chomp
                info[:last_name] = last_name
            puts"-----------------------------------"
            puts"Please enter your address? :".yellow
                address = {}
                info[:address]= address
            puts"-----------------------------------"


                if (11410..12000).cover?(zip_code)
                    address[:county] = "New York"
                else
                    puts "Unfortunately we don't serve your community yet"
                    exit
                end

                if !info.nil?
                    @account = BankAccount.new(info)
                    puts"-----------------------------------"
                    puts"\n"
                    puts"Account has been successfully created".yellow
                    puts"Your Account number is #{account_number}".blue
                    puts"your balance is #{balance}".red
                    puts"\n"
                    @account.save()
                else
                    puts "unable to create account at this time"
                    break
                end

        when 3(change this)
            loop do
                puts"\n"
                puts "What do you want to do today?"
                puts"-----------------------------------"
                puts"1)Deposit  2)Withdrawal 3)Transfer 4)Balance 5)Exit"
                print"your choice :"
                ans = gets.chomp.to_i
                case ans
                when 1
                    puts"\n"

                when 5
                    break
                end

            end
        when 4
            puts BankAccount.account_list
        when 5
             puts "in construction"
        when 6
            break
        end

    end

end

class BankAccount < Person
    include Run

    attr_accessor :balance, :pin
    @@account_list = []
    @@count = 0

    def initialize(balance)
        super
        @info[:transaction]={}
        @info[:transaction][:deposit]=[]
        @info[:transaction][:withdrawal]=[]
        @account_number = @@count += 1
        @balance=0
        @pin=0
        @@account_list << @account
        open()
    end

      def open
        if File.exist?("bank_account.yml")
          @@account_list = YAML.load_file("bank_account.yml")
        end
      end

      def save
        File.open("bank_account.yml", "w") do |file|
          file.write(@@account_list.to_yaml)
        end
      end

    def set_pin(number)
        self.info[:pin] = number
        puts"-----------------------------------"
        puts "Your pin was successfully changed "
        puts"-----------------------------------"
    end

    def self.account_list
        puts"---------------------------------"
        puts"       Accounts Lists            "
        puts"---------------------------------"
        @@account_list.each do |account|
            puts "#{account.full_name} | #{account[:account_number]} | $#{account[:balance]}"
            puts"---------------------------------"
        end
     end
