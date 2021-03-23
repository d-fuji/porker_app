# 名前空間使う?
# ↑のメリットは？

## ポーカーの役判定
STRAIGHT_FLASH = "Straight flash"
FOUR_OF_A_KIND = "Four of a kind"
FULL_HOUSE = "Full house"
FLASH = "Flash"
STRAIGHT = "Straight"
THREE_OF_A_KIND = "Three of a kind"
TWO_PAIR = "Two pair"
ONE_PAIR = "One pair"
HIGH_CARD = "High card"

## エラー判定
INVALID_HANDS_FORMAT_ERROR = '5つのカード指定文字を半角スペース区切りで入力してください。（例："S1 H3 D9 C13 S11"）'
INVALID_CARD_ERROR = '半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。'
HAS_SAME_CARD_ERROR = 'カードが重複しています。'
