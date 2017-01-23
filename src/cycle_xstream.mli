type ('t, 'a) t
type base
type memory
type 'a base_t = (base, 'a) t
type 'a memory_t = (memory, 'a) t

val periodic : int -> ('t, int) t
val singleton : 'a -> ('t, 'a) t

external combine2 : ('t, 'a) t -> ('t, 'b) t -> ('t, ('a * 'b)) t =
  "" [@@bs.module "./xstream_combine", "Xstream_combine"]

external map : ('a -> 'b) -> ('t, 'b) t =
  "" [@@bs.send.pipe: ('t, 'a) t]

external map_to : 'b -> ('t, 'b) t =
  "mapTo" [@@bs.send.pipe: ('t, 'a) t]

external fold : ('b -> 'a -> 'b) -> 'b -> ('t, 'b) t =
  "" [@@bs.send.pipe: ('t, 'a) t]

external remember : 'a base_t -> 'a memory_t = "" [@@bs.send]
external start_with : 'a -> 'a memory_t =
  "startWith" [@@bs.send.pipe: 'a base_t]

