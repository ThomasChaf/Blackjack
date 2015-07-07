require_relative "human"
require_relative "brain"
require_relative "cart"
require "json"

class Player < Human

    def initialize args
        @actions = JSON.parse(File.read("config.json"))
        @money = args[:money]
        @brain = Brain.new args
        super
    end

    def send_mise hand, mise
        @money -= mise
        hand.set_mise mise
        puts "Player mise $#{ mise }: TOTAL [$#{@money}]"
    end

    def mise
        send_mise @hand, @brain.mise
    end

    def hit hand
        puts "Player hit #{hand.to_s}"
        hand << self.hit_card
    end

    def abandon hand
        puts "Player abandon #{hand.to_s}"
        @money += (hand.mise / 2)
    end

    def stand hand
        puts "Player stand #{hand.to_s}"
    end

    def double hand
        puts "Player double"
        @double = true
        send_mise hand, hand.mise
        hand << self.hit_card
        puts "     #{ hand }"
    end

    def split hand
        puts "Player split"
        @split = true
        send_mise hand, hand.mise
        @hand = Hand.new hand.carts[0], self.hit_card
        @hand_split = Hand.new hand.carts[1], self.hit_card
        each_hand { |h| h.set_mise hand.mise }
        puts "    #{@hand.to_s}"
        puts "    #{@hand_split.to_s}"
    end

    def get_action bank_score, hand
        (@actions[bank_score.to_s]).each do |action|
            return action["fct"] if hand.eql?(action["cart"])
        end
        puts "Error no action for hand: #{ hand.to_s }"
    end

    def _play bank_score, hand
        action = get_action bank_score, hand
        if action == "double" || action == "split"
            action = "hit"
        elsif action == "abandon"
            action = "hit"
        end
        self.send action, hand
        action == "hit"
    end

    def play_loop bank_score, hand
        continue = true
        while continue and hand.score < 21
            continue = _play bank_score, hand
        end
    end

    def play bank_score
        @double = false
        @split = false
        puts "Player start #{@hand.to_s }: #{@hand.score} against #{ bank_score }"
        first_action = get_action(bank_score, @hand)
        if first_action == "split"
            split @hand
            play_loop bank_score, @hand
            play_loop bank_score, @hand_split
        elsif first_action == "double"
            double @hand
            play_loop bank_score, @hand
        elsif first_action == "abandon"
            abandon @hand
            return :abandon
        else
            play_loop bank_score, @hand
        end
        puts "Player end #{ @hand.score }"
        if @split
            puts "Player end #{ @hand_split.score }"
        end
        return :played
    end

    def money
        @money
    end

    def brain
        @brain
    end

    def win hand, value=1
        puts "WIN #{hand.mise} * #{value}: #{@money}"
        @money += (hand.mise * value)
    end

    def get_price_for_hand bank_score, hand
        puts "#{hand.score} VS #{bank_score}"
        return if hand.score > 21

        if hand.score == bank_score
            win hand
        elsif hand.is_blackjack
            win hand, 2.5
        elsif bank_score > 21 || hand.score > bank_score
            win hand, 2 * (@double ? 2 : 1)
        end
    end

    def get_price bank_score
        get_price_for_hand bank_score, @hand
        if @split
            get_price_for_hand bank_score, @hand_split
        end
    end

end
