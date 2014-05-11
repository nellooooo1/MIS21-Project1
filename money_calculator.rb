class MoneyCalculator
	attr_accessor :ones, :fives, :tens, :twenties, :fifties, :hundreds, :five_hundreds, :thousands, :change, :bills, :payment

  def initialize(ones, fives, tens, twenties, fifties, hundreds, five_hundreds, thousands)
    # each parameter represents the quantity per denomination of money
    # these parameters can be assigned to instance variables and used for computation

    # add a method called 'change' that takes in a parameter of how much an item costs
    # and returns a hash of how much change is to be given
    # the hash will use the denominations as keys and the amount per denomination as values
    # i.e. {:fives => 1, fifties => 1, :hundreds => 3}

    @ones = ones.to_i * 1
    @fives = fives.to_i * 5
    @tens = tens.to_i * 10
    @twenties = twenties.to_i * 20
    @fifties = fifties.to_i * 50
    @hundreds = hundreds.to_i * 100
    @five_hundreds = five_hundreds.to_i * 500
    @thousands = thousands.to_i * 1000

    @payment = @ones.to_i + @fives.to_i + @tens.to_i + @twenties.to_i +
                    @fifties.to_i + @hundreds.to_i + @five_hundreds.to_i + @thousands.to_i

    @bills = {'ones'=>0, 'fives'=>0, 'tens'=>0, 'twenties'=>0,
                    'fifties'=>0, 'hundreds'=>0, 'five_hundreds'=>0, 'thousands'=>0}
  end

    def get_change(amount)
        @change = @payment - amount.to_i
        get_bills()
    end

    def get_bills()
        while @change > 0
            while @change - 1000 >= 0
                bills['thousands'] += 1
                @change -= 1000
            end

            while @change - 500 >= 0
                bills['five_hundreds'] += 1
                @change -= 500
            end

            while @change - 100 >= 0
                bills['hundreds'] += 1
                @change -= 100
            end

            while @change - 50 >= 0
                bills['fifties'] += 1
                @change -= 50
            end

            while @change - 20 >= 0
                bills['twenties'] += 1
                @change -= 20
            end

            while @change - 10 >= 0
                bills['tens'] += 1
                @change -= 10
            end

            while @change - 5 >= 0
                bills['fives'] += 1
                @change -= 5
            end

            while @change - 1 >= 0
                bills['ones'] += 1
                @change -= 1                
            end
        end
    end
end