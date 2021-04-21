# frozen_string_literal: true

class Hand
  attr_accessor :error, :role
  attr_accessor :hands, :cards

  def initialize(hands)
    self.error = []
    self.role = []
    self.cards = []
    self.hands = hands
    hands = hands.split
    hands.each do |hand|
      cards.push(Card.new(suit: hand[0], number: hand[1..]))
    end
  end

  def valid?
    validations = ValidationService.new

    if validations.invalid_format?(hands: hands)
      error.push(INVALID_HANDS_FORMAT_ERROR)
      false
    elsif validations.invalid_value?(cards: cards)
      error.push(INVALID_CARD_ERROR, validations.error_messages)
      error.flatten!
      false
    elsif validations.doubled?(cards: cards)
      error.push(HAS_SAME_CARD_ERROR)
      false
    else
      true
    end
  end

  def judge
    judges = JudgeService.new(cards)

    if judges.flash? && judges.straight?
      role.push(STRAIGHT_FLASH)
    elsif judges.four_of_a_kind?
      role.push(FOUR_OF_A_KIND)
    elsif judges.full_house?
      role.push(FULL_HOUSE)
    elsif judges.flash?
      role.push(FLASH)
    elsif judges.straight?
      role.push(STRAIGHT)
    elsif judges.three_of_a_kind?
      role.push(THREE_OF_A_KIND)
    elsif judges.twopair?
      role.push(TWO_PAIR)
    elsif judges.onepair?
      role.push(ONE_PAIR)
    else
      role.push(HIGH_CARD)
    end
  end
end
