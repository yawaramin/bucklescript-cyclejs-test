(** Comment tree. *)
module Ct = Map_tree

type comment
type t
type sources = < _DOM : Cycle.Dom.Source.t > Js.t
type sinks =
  < _DOM : Cycle.Dom.vnode Cycle_xstream.memory_t;
    comments : comment Ct.t Cycle_xstream.memory_t > Js.t

val main : sources -> sinks

