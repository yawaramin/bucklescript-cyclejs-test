type t

val id : t -> int
val reply_to : t -> int option
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
val view : ('a, 'b) Cycle.Dom.Source.t -> t -> Cycle.Dom.vnode

