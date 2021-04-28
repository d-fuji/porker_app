module V1
    class Cards < Grape::API
        
        post '/cards/check' do
            input_cards_list = params[:cards]
            json = {
                results: [],
                errors: []
            }

            input_cards_list.each do |input_cards|
                hand = Hand.new(input_cards)
                if hand.api_valid?
                    hand.judge
                    json[:results].push({
                        card: input_cards,
                        hand: hand.role[0],
                        best: false
                    })
                else
                    hand.error.each do |e|
                        json[:errors].push({
                            card: input_cards,
                            message: e
                            })
                    end
                end
            end

            # TODO: エラーがない時はerrors配列を削除する。
            if json[:errors].size == 0
                json.delete(:errors)
            end

            # TODO: resultsの中で一番いい手札をbest: trueに変える。
            strongest_role_counter = 0
            ROLES.each do |role|
                if strongest_role_counter > 0
                    break
                end
                i = 0
                while i < json[:results].size
                    if role == json[:results][i][:hand]
                        json[:results][i][:best] = true
                        strongest_role_counter += 1
                    end
                    i += 1
                end
            end

            # TODO: https://example.com/api/v1/cards/check 以外のエンドポイントにリクエストが送られた時にerrorのjsonを返す。

            present json
        end
    end
end
