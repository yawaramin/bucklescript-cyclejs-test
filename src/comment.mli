type t
type ('a, 'b) sources = < _DOM : ('a, 'b) Cycle.Dom.Source.t > Js.t
type sinks =
  < _DOM : Cycle.Dom.vnode Cycle_xstream.base_t;
    numComments : int Cycle_xstream.base_t;
    comments : t Cycle_xstream.base_t > Js.t

val id : t -> int
val reply_to : t -> int option
val replies : t -> t list
val timestamp : t -> Js_date.t
val author : t -> string
val msg : t -> string

val main : ('a, 'b) sources -> sinks

