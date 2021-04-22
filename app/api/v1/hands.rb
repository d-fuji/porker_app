module V1
    class Hands < Grape::API
        desc 'returns all authors'
        get '/' do
            @retval = { ping: 'pong' }
            present @retval
        end
    end
end