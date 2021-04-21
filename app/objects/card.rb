# frozen_string_literal: true

class Card
  attr_accessor :suit, :number, :value

  def initialize(suit:, number:)
    self.suit = suit
    self.number = number
    self.value = suit + number
  end
end
