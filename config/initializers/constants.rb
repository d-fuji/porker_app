# 定数の共通化

## ポーカーの役判定
STRAIGHT_FLASH = {msg: "Straight flash"}
FOUR_OF_A_KIND = {msg: "Four of a kind"}
FULL_HOUSE = {msg: "Full house"}
FLASH = {msg: "Flash"}
STRAIGHT = {msg: "Straight"}
THREE_OF_A_KIND = {msg: "Three of a kind"}
TWO_PAIR = {msg: "Two pair"}
ONE_PAIR = {msg: "One pair"}
HIGH_CARD = {msg: "High card"}

## エラー判定
INVALID_HANDS_FORMAT_ERROR = {type: "error", msg: '5つのカード指定文字を半角スペース区切りで入力してください。（例："S1 H3 D9 C13 S11"）'}
INVALID_CARD_ERROR = {type: "error", msg: '半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。', contents: nil}
HAS_SAME_CARD_ERROR = {type: "error", msg: 'カードが重複しています。'}
