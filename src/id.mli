type t

external of_int : int -> t = "%identity"
external to_int : t -> int = "%identity"
val incr : t -> t
val decr : t -> t

