type t

external of_event_target : Web_event_target.t -> t = "%identity"
external value : t -> string = "nodeValue" [@@bs.get]

