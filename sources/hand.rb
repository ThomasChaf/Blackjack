class Hand

    def initialize
        puts "hand"
        @carts = []
    end

    def score
        score = 0
        @carts.each do |cart|
            score += cart.value
        end
        score
    end

    def is_pair
        (@carts.length == 2 && @carts[0].value == @carts[1].value)
    end

    def is_blackjack
        (@carts.length == 2 && (@carts[0].to_s == "1" && @carts[1].value == "10" || @carts[0].to_s == "10" && @carts[1].value == "1"))
    end

    def has_as
        @carts.each do |cart|
            if cart.value == 1
                return true
            end
        end
        false
    end

    def eql?(cart_describer)
        if !cart_describer.class.name == ((is_pair || (has_as && @carts.length == 2)) ? "Array" : "Fixnum")
            return false
        end
        if is_pair || has_as
            cart_describer[0] == @carts[0].value && cart_describer[1] == @carts[1].value
        else
            score == cart_describer
        end
    end

    def to_s
        if @carts.length == 2
            "#{ @carts[0].to_s } - #{ @carts[1].to_s }"
        else
            "#{ @carts[0].to_s }"
        end
    end

    def clean
        @carts.clear
    end

    def << cart
        @carts << cart
    end

end
