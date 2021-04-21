# frozen_string_literal: true

class JudgeService
  attr_accessor :suits, :numbers, :counter_two, :counter_three, :counter_four

  def initialize(cards)
    self.counter_two = 0
    self.counter_three = 0
    self.counter_four = 0
    self.numbers = { '1' => 0, '2' => 0, '3' => 0, '4' => 0, '5' => 0, '6' => 0, '7' => 0, '8' => 0, '9' => 0,
                    '10' => 0, '11' => 0, '12' => 0, '13' => 0 }
    self.suits = { 'S' => 0, 'H' => 0, 'D' => 0, 'C' => 0 }
    cards.each do |card|
      numbers[card.number] += 1
      suits[card.suit] += 1
    end
    numbers.each do |_key, value|
      case value
      when 2
        self.counter_two += 1
      when 3
        self.counter_three += 1
      when 4
        self.counter_four += 1
      end
    end
  end

  def onepair?
    if self.counter_two == 1 && self.counter_three.zero?
      true
    else
      false
    end
  end

  def twopair?
    self.counter_two == 2
  end

  def three_of_a_kind?
    if self.counter_three == 1 && self.counter_two.zero?
      true
    else
      false
    end
  end

  def full_house?
    if self.counter_three == 1 && self.counter_two == 1
      true
    else
      false
    end
  end

  def four_of_a_kind?
    self.counter_four == 1
  end

  def straight?
    counter_continuous_number = 0
    numbers.each do |_key, value|
      if value == 1
        counter_continuous_number += 1
        return true if counter_continuous_number == 5
      else
        counter_continuous_number = 0
      end
    end
    false
  end

  def flash?
    suits.each do |_key, value|
      return true if value == 5
    end
    false
  end
end
