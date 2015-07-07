require_relative "hand"

class Human

    def initialize args=nil
        @hand = Hand.new
        @hand_split = Hand.new
    end

    def hand
        @hand
    end

    def each_hand
        yield @hand
        yield @hand_split
    end

    def clean_hands
        each_hand { |hand| hand.clean }
    end

    def set_hit hit_action
        @hit_action = hit_action
    end

    def hit_card
        @hit_action.call
    end

end
