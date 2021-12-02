Nonterminals command command_list.
Terminals number move.
Rootsymbol command_list.

command      -> move number : {'$1', '$2'}.
command_list -> command : ['$1'].
command_list -> command command_list : ['$1' | '$2'].