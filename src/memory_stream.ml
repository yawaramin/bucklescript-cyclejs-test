type 'a t

external map : ('a -> 'b) -> 'b t = "" [@@bs.send.pipe: 'a t]
external map_to : 'b -> 'b t = "mapTo" [@@bs.send.pipe: 'a t]
external fold : ('b -> 'a -> 'b) -> 'b -> 'b t =
  "" [@@bs.send.pipe: 'a t]

