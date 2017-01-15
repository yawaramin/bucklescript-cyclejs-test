type vnode

external vnode :
  string Js.undefined ->
  (* HTML attrs constructed using custom [%bs.obj { ... } ] *)
  < attrs : 'a > Js.t ->
  vnode array ->
  string Js.undefined ->
  'b Js.undefined ->
  vnode =
  "snabbdom/vnode" [@@bs.module]

type ('a, 'b) dom_driver = vnode Xstream.t -> 'a -> string -> 'b

external make_dom_driver : string -> ('b, 'c) dom_driver =
  "makeDOMDriver" [@@bs.module "@cycle/dom"]

external empty_attr : 'a = "" [@@bs.obj]

let h sel ?(attrs=empty_attr) children =
  vnode
    (Js.Undefined.return sel)
    [%bs.obj { attrs } ]
    (Array.of_list children)
    Js.undefined
    Js.undefined

let text string =
  vnode
    Js.undefined
    empty_attr
    [||]
    (Js.Undefined.return string)
    Js.undefined

module Source = Cycle_dom_source

