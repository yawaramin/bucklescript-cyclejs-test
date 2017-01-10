type vnode

val h :
  sel:string ->
  attrs:'a ->
  children:vnode list ->
  vnode

val text : string -> vnode

