require_relative "human"
require_relative "cart"

class Bank < Human

    def initialize
        puts 'bank'
        super
    end

    def play
        puts "Bank receive #{ @hand.to_s }"
        while score < 17
            c = Cart.new
            puts "  Bank add #{ c.to_s }"
            @hand << c
        end
        puts "Bank end #{ score }"
    end
end
