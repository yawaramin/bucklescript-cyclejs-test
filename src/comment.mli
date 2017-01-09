type t

val init_id : int
val make : int -> string -> string -> t
val id : t -> int
val parent_id : t -> int
val timestamp : t -> Js_date.t
val author : t -> string
val msg : t -> string
val view : t -> Cycle_dom.vnode

