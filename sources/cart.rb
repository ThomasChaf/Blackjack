class Cart

    def initialize name = Random.rand(1..13)
        @name = name
        @value = {
            1 => 1,
            2 => 2,
            3 => 3,
            4 => 4,
            5 => 5,
            6 => 6,
            7 => 7,
            8 => 8,
            9 => 9,
            10 => 10,
            11 => 10,
            12 => 10,
            13 => 10
        }[@name]
    end

    def to_s
        {
            1 => "1",
            2 => "2",
            3 => "3",
            4 => "4",
            5 => "5",
            6 => "6",
            7 => "7",
            8 => "8",
            9 => "9",
            10 => "10",
            11 => "V",
            12 => "D",
            13 => "R"
        }[@name]
    end

    def value
        @value
    end

end
