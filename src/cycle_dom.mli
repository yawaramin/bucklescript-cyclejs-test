type vnode

val h :
  sel:string ->
  ?text:string ->
  attrs:(string * string) list ->
  children:vnode list ->
  vnode

