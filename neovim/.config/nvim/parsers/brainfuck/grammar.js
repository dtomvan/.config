module.exports = grammar({
  name: "brainfuck",

  rules: {
    source_file: ($) => repeat(choice($.comment, $.expression)),
    expression: ($) =>
      choice($.back, $.forward, $.plus, $.minus, $.get, $.put, $.loop),
    back: ($) => "<",
    forward: ($) => ">",
    plus: ($) => "+",
    minus: ($) => "-",
    get: ($) => ",",
    put: ($) => ".",
    loop: ($) => seq($.loop_start, repeat(choice($.expression, $.comment)), $.loop_end),
    loop_start: ($) => "[",
    loop_end: ($) => "]",
    comment: ($) => /[^+<>\-\[\].,]+/,
  },
});
