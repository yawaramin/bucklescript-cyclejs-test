type events_fn_options = < use_capture : Js.boolean Js.undefined > Js.t

type ('a, 'b) t =
  (< select : string -> ('a, 'b) t [@bs.meth];
    elements : unit -> 'a [@bs.meth];
    events : string -> events_fn_options Js.undefined [@bs.meth];
    .. > as 'b) Js.t
