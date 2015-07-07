require_relative "human"
require_relative "cart"

class Bank < Human

    def initialize
        super
    end

    def score
        hand.score
    end

    def visible_cart
        @hand.carts.first
    end

    def play
        while @hand.score < 17
            @hand << self.hit_card
            puts "Bank hit #{hand.to_s}"
        end
        puts "Bank end #{ hand.score }"
    end
end
