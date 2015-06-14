require_relative "human"
require_relative "cart"
require "json"

class Player < Human

    def initialize args
        puts "player"
        @actions = JSON.parse(File.read("config.json"))
        @money = args[:money]
        @mise = args[:mise]
        super
    end

    def hit
        puts "  hit"
        @hand << Cart.new
    end

    def abandon
        puts "abandon"
    end

    def stand
        puts "stand"
    end

    def double
        puts "double"
        @hand << Cart.new
        @money -= @mise
        @double = true
    end

    def split
        puts "split"
    end

    def _play bank_score
        puts "    score: #{ score } vs #{ bank_score }"
        (@actions[bank_score.to_s]).each do |action|
            if @hand.eql?(action["cart"])
                self.send action["fct"]
                return action["fct"] == "hit"
            end
        end
        puts "Error no action founded for hand #{ @hand.to_s }"
    end

    def play bank_score
        @double = false
        @money -= @mise
        puts "I have: #{ @hand.to_s }"
        while _play(bank_score) && score <= 21
            true
        end
        puts "End: #{ score }"
    end

    def hand
        @hand
    end

    def win value=1
        @money += ((@double ? 2 : 1) * @mise * value)
    end

    def money
        @money
    end

end
