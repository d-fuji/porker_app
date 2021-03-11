class JudgeController < ApplicationController

  def index
    @hands = params[:hands]
    if @hands
      judge = Judge.new(@hands)
      res = judge.main
      if res[:type] == "error"
        @msg = res[:msg]
        @contents = res[:contents]
      else
        @res = res[:msg]
      end
    end
  end
end
