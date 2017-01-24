type t

external of_node : Web_node.t -> t = "%identity"
external id : t -> string = "" [@@bs.get]

