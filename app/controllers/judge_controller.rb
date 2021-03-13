class JudgeController < ApplicationController

  def index
    @hands = params[:hands]
    @messages = []
    if @hands
      judge = Judge.new(@hands)
      @messages = judge.return_messages
    end
  end
end
