type 'a t

val periodic : int -> int t
val singleton : 'a -> 'a t
val remember : 'a t -> 'a Memory_stream.t

