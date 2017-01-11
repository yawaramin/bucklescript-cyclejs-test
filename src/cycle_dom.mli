type vnode

type ('a, 'b) dom_driver = vnode Xstream.t -> 'a -> string -> 'b

val make_dom_driver : string -> ('b, 'c) dom_driver

val h :
  string ->
  ?attrs:'a ->
  vnode list ->
  vnode

val text : string -> vnode

