type t
type ('a, 'b) sources = < dom : ('a, 'b) Cycle.Dom.Source.t > Js.t
type sinks =
  < dom : Cycle.Dom.vnode Memory_stream.t;
    numComments : int Memory_stream.t;
    comments : t Memory_stream.t > Js.t

val id : t -> int
val reply_to : t -> int option
val replies : t -> t list
val timestamp : t -> Js_date.t
val author : t -> string
val msg : t -> string

val main : ('a, 'b) sources -> sinks

