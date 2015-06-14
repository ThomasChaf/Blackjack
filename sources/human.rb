require_relative "hand"

class Human

    def initialize args=nil
        @hand = Hand.new
    end

    def score
        @hand.score
    end

    def clean_hand
        @hand.clean
    end

    def << cart
        @hand << cart
    end

end
