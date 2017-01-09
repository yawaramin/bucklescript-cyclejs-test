type vnode
type attrs

external vnode :
  string Js.undefined ->
  attrs ->
  vnode array ->
  string Js.undefined ->
  'a Js.undefined ->
  vnode =
  "snabbdom/vnode" [@@bs.module]

type ('a, 'b) dom_driver = vnode Xstream.t -> 'a -> string -> 'b

external make_dom_driver : string -> ('b, 'c) dom_driver =
  "makeDOMDriver" [@@bs.module "@cycle/dom"]

let option_to_undefined = function
  Some x -> Js.Undefined.return x | None -> Js.undefined

external make_attrs : ?key:string -> unit -> attrs = "" [@@bs.obj]

let assoc_option x list =
  if List.mem_assoc x list then Some (List.assoc x list) else None

let h sel attrs children =
  let attrs' = make_attrs ?key:(assoc_option "key" attrs) () in

  vnode
    (Js.Undefined.return sel)
    attrs'
    (Array.of_list children)
    Js.undefined
    Js.undefined

let text string =
  vnode
    Js.undefined
    (make_attrs ())
    [||]
    (Js.Undefined.return string)
    Js.undefined

