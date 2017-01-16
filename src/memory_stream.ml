type 'a t
type ('a, 'b) combine_arr = { a : 'a; b : 'b }

external xstream :
  < _MemoryStream :
    < periodic : int -> int t [@bs.meth];
      never : _ t;
      empty : _ t;
      throw : 'a -> _ t [@bs.meth];
      fromArray : 'b array -> 'b t [@bs.meth];
      combine :
        ('c t, 'd t) combine_arr -> ('c, 'd) combine_arr t [@bs.meth];

      .. > Js.t;

    .. > Js.t =
  "" [@@bs.module]

let combine2 a b = xstream##_MemoryStream##combine { a; b }
external map : ('a -> 'b) -> 'b t = "" [@@bs.send.pipe: 'a t]
external map_to : 'b -> 'b t = "mapTo" [@@bs.send.pipe: 'a t]
external fold : ('b -> 'a -> 'b) -> 'b -> 'b t =
  "" [@@bs.send.pipe: 'a t]

