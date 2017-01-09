type vnode
type attrs

external vnode :
  string ->
    attrs ->
    vnode list ->
    string Js.undefined ->
    'a Js.undefined ->
    vnode =
  "snabbdom/vnode" [@@bs.module]

type ('a, 'b) dom_driver = vnode Xstream.t -> 'a -> string -> 'b

external make_dom_driver : string -> ('b, 'c) dom_driver =
  "makeDOMDriver" [@@bs.module "@cycle/dom"]

let option_to_undefined = function
  Some x -> Js.Undefined.return x | None -> Js.undefined

external make_attrs :
  ?id:string ->
    ?key:string ->
    ?className:string ->
    unit ->
    attrs = "" [@@bs.obj]

let assoc_option x list =
  if List.mem_assoc x list then Some (List.assoc x list) else None

let h sel ?text attrs children =
  let attrs' =
    make_attrs
      ?id:(assoc_option "id" attrs)
      ?key:(assoc_option "key" attrs)
      ?className:(assoc_option "class" attrs)
      () in

  vnode sel attrs' children (option_to_undefined text) Js.undefined

