type t

val select : string -> t -> t
val elements : t -> Web.Element.t array Cycle_xstream.base_t
val events : string -> t -> Web.Event.t Cycle_xstream.base_t

