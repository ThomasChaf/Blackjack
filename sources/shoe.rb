class Deck

    def self.CREATE
        [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13].map do |value|
            4.times.map { Cart.new(value) }
        end
        # [7, 1, 10, 8, 10, 9].map do |value|
        #     Cart.new(value)
        # end
    end

end

class Shoe < Array

    def initialize nb_deck
        @nb_deck = nb_deck
    end

    def mix
        @update.call nil
        self.clear
        @nb_deck.times do
            self << Deck.CREATE
        end
        self.flatten!
        self.shuffle!
    end

    def observable update
        @update = update
    end

    def hit
        cart = self.shift
        @update.call cart
        if cart.nil?
            self.mix
            cart = self.hit
        end
        cart
    end

end
