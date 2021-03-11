class JudgeController < ApplicationController

  def index
    @hands = params[:hands]
    @messages = []
    if @hands
      judge = Judge.new(@hands)
      res = judge.main
      if res[:type] == "error"
        @messages.push(res[:msg])
        contents = res[:contents]
        contents.each do |key, value|
          @messages.push("#{key}番目のカード指定文字が不正です。(#{value})")
        end
      else
        @messages.push(res[:msg])
      end
    end
  end
end
