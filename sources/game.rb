require_relative 'player'
require_relative 'bank'
require_relative 'shoe'

class Game

    def initialize args
        @shoe = Shoe.new args[:nb_deck]
        @player = Player.new args
        @bank = Bank.new

        @player.set_hit lambda { @shoe.hit }
        @bank.set_hit lambda { @shoe.hit }

        @shoe.observable lambda { |value| @player.brain.observe value }
        @shoe.mix
    end

    def end?
        @player.money <= 0
    end

    def deal
        @player.hand << @player.hit_card
        @player.hand << @player.hit_card
        @bank.hand << @bank.hit_card
    end

    def play
        @player.mise
        if @player.play(@bank.visible_cart.value) != :abandon
            @bank.play
            @player.get_price @bank.score
        end
        puts "$#{@player.money}"
        @player.clean_hands
        @bank.clean_hands
    end

end
