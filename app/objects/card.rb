class Card
    
    attr_accessor :suit, :number

    def initialize(suit:, number:)
        self.suit = suit
        self.number = number
    end

    def get_combined_value
        self.suit + self.number
    end
end