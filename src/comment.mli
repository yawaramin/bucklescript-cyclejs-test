type t

val make :
  int -> ?reply_to:t -> ?replies:t list -> string -> string -> t

val id : t -> int
val reply_to : t -> t option
val replies : t -> t list
val timestamp : t -> Js_date.t
val author : t -> string
val msg : t -> string

val init_comment : t

(**
Returns a comment with the given reply added.

@param    t the reply to add.
@param to_t the parent comment to reply to.
*)
val reply : t -> t -> t
val view : t -> Cycle_dom.vnode

