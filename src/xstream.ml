type 'a t

external xstream :
  < default :
    < periodic : int -> int t [@bs.meth];
      never : _ t;
      empty : _ t;
      throw : 'a -> _ t [@bs.meth];
      fromArray : 'b array -> 'b t [@bs.meth];
      .. > Js.t; .. > Js.t =
  "" [@@bs.module]

let periodic period = xstream##default##periodic period
let of_array array = xstream##default##fromArray array
let singleton x = of_array [|x|]

external map : ('a -> 'b) -> 'b t = "" [@@bs.send.pipe: 'a t]
external map_to : 'b -> 'b t = "mapTo" [@@bs.send.pipe: 'a t]
external fold : ('b -> 'a -> 'b) -> 'b -> 'b t =
  "" [@@bs.send.pipe: 'a t]

