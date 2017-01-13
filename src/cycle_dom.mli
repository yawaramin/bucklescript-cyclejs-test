type vnode
type ('a, 'b) dom_driver = vnode Cycle_xstream.t -> 'a -> string -> 'b

val make_dom_driver : string -> ('b, 'c) dom_driver
val h : string -> ?attrs:'a -> vnode list -> vnode
val text : string -> vnode

module Source = Cycle_dom_source

