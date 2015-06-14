require_relative "player"
require_relative "bank"

class Game

    def initialize args
        @player = Player.new args
        @bank = Bank.new
        @round = 0
    end

    def has_player
        @player.money > 0
    end

    def winner
        puts "comp: #{@player.score}-#{@bank.score}"
        if @player.score > 21
            return
        end
        if @player.hand.is_blackjack
            @player.win 2.5
        elsif @player.score == @bank.score
            @player.win
        elsif @bank.score > 21 || @player.score > @bank.score
            @player.win 2
        end
    end

    def play
        @player << Cart.new << Cart.new
        @bank << Cart.new
        puts "=== ROUND === #{ @round }"
        @player.play @bank.score
        @bank.play
        winner
        puts @player.money
        @player.clean_hand
        @bank.clean_hand
        @round += 1
    end
end
