type vnode

val h :
  sel:string ->
  attrs:(string * string) list ->
  children:vnode list ->
  vnode

val text : string -> vnode

