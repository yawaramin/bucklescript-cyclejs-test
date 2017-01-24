type events_fn_options = < use_capture : Js.boolean Js.undefined > Js.t

type t =
  < select : string -> t [@bs.meth];
    elements :
      unit ->
      Web.Element.t array Cycle_xstream.base_t [@bs.meth];

    events :
      string ->
      events_fn_options Js.undefined ->
      Web.Event.t Cycle_xstream.base_t [@bs.meth] > Js.t

let select string t = t##select string
let elements t = t##elements ()
let events string t = t##events string Js.undefined

