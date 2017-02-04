module Comment_id = Id
module Ds = Cycle.Dom.Source
module Xs = Cycle_xstream

type t =
  { id : Comment_id.t;
    author : string;
    msg : string;
    timestamp : Js_date.t option }

type action = Reply of t
type 't sources =
  < _DOM : Cycle.Dom.Source.t; comment : ('t, t) Cycle_xstream.t > Js.t

type sinks =
  < _DOM : Cycle.Dom.vnode Cycle_xstream.memory_t;
    actions : action Cycle_xstream.memory_t > Js.t

let make id author msg timestamp = { id; author; msg; timestamp }
let datetime_format =
  let num = "numeric" in

  Intl.Date_time_format.make
    ~options:
      [%bs.obj
        { year = num;
          month = num;
          day = num;
          hour = num;
          minute = num;
          second = num;
          hour12 = Js.false_ } ]

    ~locales:["en-CA-u-ca-iso8601"]
    ()

let append suffix to_string = to_string ^ suffix
let edit_reply_class = ".edit-reply"
let start_reply_class = ".start-reply"
let cancel_reply_class = ".cancel-reply"
let save_reply_class = ".save-reply"
let view = Xs.map (fun { id; author; msg; timestamp } ->
  let open Cycle.Dom in
  let id_str = id |> Comment_id.to_int |> string_of_int in
  let body =
    match timestamp with
      | Some ts -> (* This is a saved comment. *)
        [ h "span" [
            h "strong" [author |> append " " |> text];
            msg |> append " " |> text ];

          h "span.control.has-addons" [
            h ("button.button.is-small.up") [text "+1"];
            h ("button.button.is-small.down") [text "-1"];
            h "span.button.is-small.is-disabled" [
              datetime_format
                |> Intl.Date_time_format.format ts
                |> append " "
                |> text ];

            h (append "button.button.is-small" start_reply_class) [
              text "Reply" ] ] ]

      (*
      This is an unsaved comment, i.e. it's currently being edited.
      *)
      | None ->
        [ h "p.control" [
            h (append "textarea.textarea" edit_reply_class)
              ~attrs:[%bs.obj { _type = "text" } ] [] ];

          h "p.control.has-addons" [
            h (append "button.button.is-small" save_reply_class) [
              text "Send" ];

            h (append "button.button.is-small" cancel_reply_class) [
              text "Cancel" ] ] ] in

  h "div" ~attrs:[%bs.obj { key = id_str } ] body)

let author = "bob"
let actions dom =
  let class_click_action c a =
    dom |> Ds.select c |> Ds.events "click" |> Xs.map_to a in

  Xs.merge4
    (dom
      |> Ds.select edit_reply_class
      |> Ds.events "input"
      |> Xs.map (fun e ->
        let open Web in
        let value =
          e |> Event.target
            |> Node.of_event_target
            |> Element.of_node
            |> Html_element.of_element
            |> Html_textarea_element.of_html_element
            |> Html_textarea_element.value in

        `Edit_reply value))

    (class_click_action start_reply_class `Start_reply)
    (class_click_action cancel_reply_class `Cancel_reply)
    (class_click_action save_reply_class `Save_reply)

let stamp_time c = { c with timestamp = Some (Js_date.now ()) }
let with_msg msg c = { c with msg }
let model =
  let init_id = 1 in
  let init_comment_id = Comment_id.of_int init_id in
  let init_comment =
    { id = init_comment_id;
      author;
      msg = "Hello, World!";
      timestamp = Some (Js_date.now ()) } in

  let init_comment_tree = Ct.empty |> Ct.add init_id init_comment in
  let update (next_id, comment_tree) = function
    | Start_reply_to (id, author) ->
      let parent_id = Comment_id.to_int id in
      let reply =
        { id = next_id; author; msg = ""; timestamp = None } in

      Comment_id.incr next_id,
      Ct.add ~parent_id (Comment_id.to_int next_id) reply comment_tree

    | Save_reply id ->
      next_id,
      Ct.update (Comment_id.to_int id) stamp_time comment_tree

    | Cancel_reply id ->
      next_id, Ct.remove (Comment_id.to_int id) comment_tree

    | Edit_reply (id, msg) ->
      next_id,
      Ct.update (Comment_id.to_int id) (with_msg msg) comment_tree in

  let init_model = Comment_id.incr init_comment_id, init_comment_tree in

  Xs.fold update init_model

let main sources =
  let model' = sources##_DOM |> actions |> model in
  [%bs.obj { _DOM = view model'; comments = Xs.map snd model' } ]

