class Hand
  attr_accessor :response, :hands, :cards

  def initialize(hands)
    self.response = []
    self.cards = []
    self.hands = hands
    hands = hands.split
    hands.each do |hand|
      cards.push(Card.new(suit: hand[0], number: hand[1..]))
    end
  end

  def return_messages
    if satisfy_validation_item?
      judge_hands
    else
      response
    end
  end

  def satisfy_validation_item?
    validations = ValidationService.new

    if validations.is_invalid_hands_format?(hands: hands)
      response.push(INVALID_HANDS_FORMAT_ERROR)
      false
    elsif validations.is_invalid_card?(cards: cards)
      response.push(INVALID_CARD_ERROR, validations.get_invalid_card_messages)
      response.flatten!
      false
    elsif validations.has_same_card?(cards: cards)
      response.push(HAS_SAME_CARD_ERROR)
      false
    else
      true
    end
  end

  def judge_hands
    judges = JudgeService.new(cards)

    if judges.is_flash? && judges.is_straight?
      response.push(STRAIGHT_FLASH)
    elsif judges.is_four_of_a_kind?
      response.push(FOUR_OF_A_KIND)
    elsif judges.is_full_house?
      response.push(FULL_HOUSE)
    elsif judges.is_flash?
      response.push(FLASH)
    elsif judges.is_straight?
      response.push(STRAIGHT)
    elsif judges.is_three_of_a_kind?
      response.push(THREE_OF_A_KIND)
    elsif judges.is_twopair?
      response.push(TWO_PAIR)
    elsif judges.is_onepair?
      response.push(ONE_PAIR)
    else
      response.push(HIGH_CARD)
    end
  end
end
