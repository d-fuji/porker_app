class Judge

    attr_accessor :response
    attr_accessor :hands
    attr_accessor :cards

    def initialize(hands)
        self.response = []
        self.cards = []
        self.hands = hands
        hands = hands.split
        hands.each do |hand|
            self.cards.push(Card.new(suit: hand[0], number: hand[1..]))
        end
    end

    def return_messages
        if satisfy_validation_item?
            judge_hands
        else
            self.response
        end
    end

    def satisfy_validation_item?

        validations = ValidationService.new

        if validations.is_invalid_hands_format?(hands: self.hands)
            self.response.push(INVALID_HANDS_FORMAT_ERROR)
            return false
        elsif validations.is_invalid_card?(cards: self.cards)
            self.response.push(INVALID_CARD_ERROR, validations.get_invalid_card_messages)
            self.response.flatten!
            return false
        elsif validations.has_same_card?(cards: self.cards)
            self.response.push(HAS_SAME_CARD_ERROR)
            return false
        else
            return true
        end
    end

    def judge_hands

        judges = JudgeService.new(self.cards)

        if judges.is_flash? && judges.is_straight?
            self.response.push(STRAIGHT_FLASH)
        elsif judges.is_four_of_a_kind?
            self.response.push(FOUR_OF_A_KIND)
        elsif judges.is_full_house?
            self.response.push(FULL_HOUSE)
        elsif judges.is_flash?
            self.response.push(FLASH)
        elsif judges.is_straight?
            self.response.push(STRAIGHT)
        elsif judges.is_three_of_a_kind?
            self.response.push(THREE_OF_A_KIND)
        elsif judges.is_twopair?
            self.response.push(TWO_PAIR)
        elsif judges.is_onepair?
            self.response.push(ONE_PAIR)
        else
            self.response.push(HIGH_CARD)
        end
    end
end