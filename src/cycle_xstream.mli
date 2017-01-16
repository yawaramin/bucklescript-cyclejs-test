type 'a t

val periodic : int -> int t
val singleton : 'a -> 'a t
val combine2 : 'a t -> 'b t -> ('a * 'b) t
val remember : 'a t -> 'a Memory_stream.t

external map : ('a -> 'b) -> 'b t = "" [@@bs.send.pipe: 'a t]

