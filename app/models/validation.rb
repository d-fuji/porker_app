class Validation
    
    def is_invalid_hands_format?(hands:)
        if /^\S*\s\S*\s\S*\s\S*\s\S*$/ === hands
            return false
        end
        return true
    end

    def is_invalid_card?(cards:)
        cards.each do |card|
            if /^[SHDC](?:[1-9]$|1[0-3]$)/ === card.get_symbol
            else
                return true
            end
        end
        return false
    end

    def show_invalid_cards(cards:)
        errors = {}
        counter = 1
        cards.each do |card|
            if /^[SHDC](?:[1-9]$|1[0-3]$)/ === card.get_symbol
            else
                errors[counter] = card.get_symbol
            end
            counter += 1
        end
        return errors
    end

    def has_same_card?(cards:)
        ary = []
        cards.each do |card|
            ary.push(card.get_symbol)
        end
        return (ary.count - ary.uniq.count) > 0
    end
end