# frozen_string_literal: true

class ValidationService
  attr_accessor :error_messages

  def initialize
    self.error_messages = []
  end

  def invalid_format?(hands:)
    !(/^\S*\s\S*\s\S*\s\S*\s\S*$/ === hands)
  end

  def invalid_value?(cards:)
    invalid_value = false
    counter = 1
    cards.each do |card|
      if /^[SHDC](?:[1-9]$|1[0-3]$)/ === card.value
        # do nothing
      else
        error_messages.push("#{counter}番目のカード指定文字が不正です。(#{card.value})")
        has_invalid_card = true
      end
      counter += 1
    end
    invalid_card
  end

  def doubled?(cards:)
    cards_list = []
    cards.each do |card|
      cards_list.push(card.value)
    end
    (cards_list.count - cards_list.uniq.count).positive?
  end
end
