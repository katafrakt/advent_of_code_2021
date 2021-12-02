Definitions.
FORWARD       = (forward)
UP            = (up)
DOWN          = (down)
WHITESPACE    = [\s\t\n]
DIGITS        = [0-9]+

Rules.
{WHITESPACE} : skip_token.
{FORWARD}    : {token, {move, forward}}.
{UP}         : {token, {move, up}}.
{DOWN}       : {token, {move, down}}.
{DIGITS}     : {token, {number, list_to_integer(TokenChars)}}.

Erlang code.