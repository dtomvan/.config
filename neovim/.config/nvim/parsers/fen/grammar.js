module.exports = grammar({
  name: "fen",

  rules: {
    source_file: ($) => repeat(seq($.fen_expr, optional("\n"))),
    fen_expr: ($) =>
      seq(
        $.rank,
        token.immediate("/"),
        $.rank,
        token.immediate("/"),
        $.rank,
        token.immediate("/"),
        $.rank,
        token.immediate("/"),
        $.rank,
        token.immediate("/"),
        $.rank,
        token.immediate("/"),
        $.rank,
        token.immediate("/"),
        $.rank,
        $.active_color,
        ' ',
        $.castling,
        $.en_passant,
        $.half_move_clock,
        $.full_move_number
      ),
    rank: ($) => repeat1(choice($.empty_spaces, $.piece)),
    empty_spaces: ($) => token.immediate(/[1-8]/),
    piece: ($) => choice($.piece_black, $.piece_white),
    piece_black: ($) => token.immediate(/[pnbrqk]/),
    piece_white: ($) => token.immediate(/[PNBRQK]/),
    active_color: ($) => token(/[wb]/),
    empty_field: ($) => token("-"),
    castling: ($) => choice($.empty_field, $.castling_available),
    castling_available: ($) =>
      repeat1(
        choice(
          $.white_kingside,
          $.white_queenside,
          $.black_kingside,
          $.black_queenside
        )
      ),
    white_kingside: ($) => token.immediate("K"),
    black_kingside: ($) => token.immediate("k"),
    white_queenside: ($) => token.immediate("Q"),
    black_queenside: ($) => token.immediate("q"),
    en_passant: ($) => choice($.empty_field, $.square),
    square: ($) => /[a-h][1-8]/,
    half_move_clock: ($) => /\d+/,
    full_move_number: ($) => /\d+/,
  },
});
