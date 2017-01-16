type events_fn_options = < use_capture : Js.boolean Js.undefined > Js.t

type ('a, 'b) t =
  (< select : string -> ('a, 'b) t [@bs.meth];
     elements : unit -> Element.t array Cycle_xstream.t [@bs.meth];
     events : string -> events_fn_options Js.undefined [@bs.meth];
     .. > as 'b) Js.t

let select string t = t##select string
let elements t = t##elements ()
let events string t = t##events string

