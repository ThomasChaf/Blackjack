class Hand

    def initialize *args
        @mise = 0
        @carts = []
        if !args.empty?
            args.each do |arg|
                @carts << arg
            end
        end
    end

    def set_mise mise
        @mise = mise
    end

    def mise
        @mise
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

    def eql?(carts)
        if is_pair || (has_as && @carts.length == 2)
            (carts[0] == @carts[0].value && carts[1] == @carts[1].value) || (carts[0] == @carts[1].value && carts[1] == @carts[0].value)
        else
            score == carts
        end
    end

    def to_s
        if @carts.length == 4
            "[4:] #{ @carts[0].to_s } - #{ @carts[1].to_s } - #{ @carts[2].to_s } - #{ @carts[3].to_s }"
        elsif @carts.length == 3
            "[3:] #{ @carts[0].to_s } - #{ @carts[1].to_s } - #{ @carts[2].to_s }"
        elsif @carts.length == 2
            "[2:] #{ @carts[0].to_s } - #{ @carts[1].to_s }"
        else
            "[1:] #{ @carts[0].to_s }"
        end
    end

    def clean
        @mise = 0
        @carts.clear
    end

    def carts
        @carts
    end

    def << cart
        @carts << cart
    end

end
