class Judge

    attr_accessor :hands
    attr_accessor :cards
    attr_accessor :suits, :numbers
    attr_accessor :counter_two, :counter_three, :counter_four

    def initialize(hands)
        self.hands = hands
        self.cards = []
        hands = hands.split
        hands.each do |hand|
            self.cards.push Card.new(suit: hand[0], number: hand[1..])
        end
    end

    def main
        validation = Validation.new
        if validation.is_invalid_hands_format?(hands: self.hands)
            return {type: "error", msg: '5つのカード指定文字を半角スペース区切りで入力してください。（例："S1 H3 D9 C13 S11"）'}
        elsif validation.is_invalid_card?(cards: self.cards)
            contents = validation.show_invalid_cards(cards: self.cards)
            return {type: "error", msg: '半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。', contents: contents}
        elsif validation.has_same_card?(cards: self.cards)
            return {type: "error", msg: 'カードが重複しています。'}
        else
            judge
        end      
    end

    def judge
        preprocess

        if is_flash? && is_straight?
            return {type: "result", msg: "Straight flash"}
        elsif is_four_of_a_kind?
            return {type: "result", msg: "Four of a kind"}
        elsif is_full_house?
            return {type: "result", msg: "Full house"}
        elsif is_flash?
            return {type: "result", msg: "Flash"}
        elsif is_straight?
            return {type: "result", msg: "Straight"}
        elsif is_three_of_a_kind?
            return {type: "result", msg: "Three of a kind"}
        elsif is_twopair?
            return {type: "result", msg: "Two pair"}
        elsif is_onepair?
            return {type: "result", msg: "One pair"}
        else
            return {type: "result", msg: "High card"}
        end
    end

    def preprocess
        self.counter_two = 0
        self.counter_three = 0
        self.counter_four = 0
        self.numbers = {"1" => 0, "2" => 0, "3" => 0, "4" => 0, "5" => 0, "6" => 0, "7" => 0, "8" => 0, "9" => 0, "10" => 0, "11" => 0, "12" => 0, "13" => 0}
        self.suits = {"S" => 0, "H" => 0, "D" => 0, "C" => 0}

        self.cards.each do |card|
            self.numbers[card.number] += 1
            self.suits[card.suit] += 1
        end

        self.numbers.each do |key, value|
            if value == 2
                self.counter_two += 1
            elsif value == 3
                self.counter_three += 1
            elsif value == 4
                self.counter_four += 1
            end
        end
    end
    
    def is_onepair?  
        if self.counter_two == 1 && self.counter_three == 0
            return true
        end
        return false
    end

    def is_twopair? 
        if self.counter_two == 2
            return true
        end
        return false
    end

    def is_three_of_a_kind?
        if self.counter_three == 1 && self.counter_two == 0
            return true
        end
        return false  
    end

    def is_full_house?
        if self.counter_three == 1 && self.counter_two == 1
            return true
        end
        return false  
    end

    def is_four_of_a_kind?
        if self.counter_four == 1
            return true
        end
        return false
    end
    
    def is_straight?
        counter_continuous_number = 0
        for key, value in self.numbers
            if value == 1
                counter_continuous_number += 1
                if counter_continuous_number == 5
                    return true
                end
            else
                counter_continuous_number = 0
            end
        end
        return false
    end

    def is_flash?
        self.suits.each do |key, value|
            if value == 5
                return true
            end
        end
        return false
    end
end