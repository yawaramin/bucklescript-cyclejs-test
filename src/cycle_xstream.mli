type ('t, 'a) t
type base
type memory
type 'a base_t = (base, 'a) t
type 'a memory_t = (memory, 'a) t

val periodic : int -> ('t, int) t
val singleton : 'a -> ('t, 'a) t
val combine2 : ('t, 'a) t -> ('t, 'b) t -> ('t, ('a * 'b)) t
val map : ('a -> 'b) -> ('t, 'a) t -> ('t, 'b) t
val map_to : 'b -> ('t, 'a) t -> ('t, 'b) t
val remember : 'a base_t -> 'a memory_t
val start_with : 'a -> 'a base_t -> 'a memory_t

