type t = int

external of_int : int -> t = "%identity"
external to_int : t -> int = "%identity"
let incr t = t + 1
let decr t = t - 1

