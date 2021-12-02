Definitions.
FORWARD       = (forward)
UP            = (up)
DOWN          = (down)
WHITESPACE    = [\s\t]
TERMINATOR    = \n
DIGITS        = [0-9]+

Rules.
{WHITESPACE} : skip_token.
{TERMINATOR} : skip_token.
{FORWARD}    : {token, {move, forward}}.
{UP}         : {token, {move, up}}.
{DOWN}       : {token, {move, down}}.
{DIGITS}     : {token, {number, list_to_integer(TokenChars)}}.

Erlang code.