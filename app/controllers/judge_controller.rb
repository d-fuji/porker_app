class JudgeController < ApplicationController
  def index
    @hands = params[:hands]
        if @hands
            @judge = Judge.new(@hands)
            @res = @judge.main
        else
            @res = "手札を入力してください"
        end
  end
end
