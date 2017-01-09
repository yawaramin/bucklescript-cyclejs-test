type t

val init_comment : t
val comment : t -> Comment.t
val replies : t -> t list
val start : int -> string -> string -> t
val reply : int -> string -> string -> t -> t
val view : t -> Cycle_dom.vnode

