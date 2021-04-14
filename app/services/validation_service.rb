# frozen_string_literal: true

class ValidationService
  attr_accessor :invalid_card_messages

  def initialize
    self.invalid_card_messages = []
  end

  def is_invalid_hands_format?(hands:)
    !(/^\S*\s\S*\s\S*\s\S*\s\S*$/ === hands)
  end

  def is_invalid_card?(cards:)
    has_invalid_card = false
    counter = 1
    cards.each do |card|
      if /^[SHDC](?:[1-9]$|1[0-3]$)/ === card.get_combined_value
      else
        invalid_card_messages.push("#{counter}番目のカード指定文字が不正です。(#{card.get_combined_value})")
        has_invalid_card = true
      end
      counter += 1
    end
    if has_invalid_card
      true
    else
      false
    end
  end

  def has_same_card?(cards:)
    cards_list = []
    cards.each do |card|
      cards_list.push(card.get_combined_value)
    end
    (cards_list.count - cards_list.uniq.count).positive?
  end

  def get_invalid_card_messages
    invalid_card_messages
  end
end
