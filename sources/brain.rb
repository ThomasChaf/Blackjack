class Brain

    def self.HILO value
        {
            1 => -1,
            2 => 1,
            3 => 1,
            4 => 1,
            5 => 1,
            6 => 1,
            7 => 0,
            8 => 0,
            9 => 0,
            10 => -1,
            11 => -1
        }[value]
    end

    def initialize args
        @money = args[:money]
        @unit_mise = @money / 500
        @nb_deck = args[:nb_deck]
        @count = 0
    end

    def observe cart
        if cart.nil?
            @count = 0
        else
            puts "Brain see: #{ cart.value } TOTAL:[#{real_count}]"
            @count += Brain.HILO(cart.value)
        end
    end

    def mise
        if self.real_count >= 3
            (self.real_count - 1) * @unit_mise
        elsif self.real_count <= -2
            @unit_mise / 2
        else
            @unit_mise
        end
    end

    def real_count
        @count / @nb_deck
    end


end
