# frozen_string_literal: true

class HandsController < ApplicationController
  def index
    @input_cards = params[:input_cards]
    @messages = []
    if @input_cards
      hand = Hand.new(@input_cards)
      if hand.valid?
        hand.judge
        @messages = hand.role
      else
        @messages = hand.error
      end
    end
  end
end
