class JudgeController < ApplicationController

  def index
    @input_cards = params[:input_cards]
    @messages = []
    if @input_cards
      judge = Judge.new(@input_cards)
      @messages = judge.return_messages
    end
  end
end
