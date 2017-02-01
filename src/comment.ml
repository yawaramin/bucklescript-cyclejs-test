module Comment_id = Id
module Ct = Map_tree
module Ds = Cycle.Dom.Source
module Xs = Cycle_xstream

type comment =
  { id : Comment_id.t;
    author : string;
    msg : string;
    timestamp : Js_date.t option }

(** A pair of the next comment ID and a comment tree. *)
type t = Comment_id.t * comment Ct.t
type action =
  | Start_reply_to of Comment_id.t * string
  | Save_reply of Comment_id.t
  | Cancel_reply of Comment_id.t
  | Edit_reply of Comment_id.t * string

type sources = < _DOM : Cycle.Dom.Source.t > Js.t
type sinks =
  < _DOM : Cycle.Dom.vnode Cycle_xstream.memory_t;
    comments : comment Ct.t Cycle_xstream.memory_t > Js.t

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

external style : 'a = "style!../../css/src/comment.css" [@@bs.module]

let _ = style
let append suffix to_string = to_string ^ suffix
let edit_reply_tag = "edit-reply"
let start_reply_tag = "start-reply"
let cancel_reply_tag = "cancel-reply"
let save_reply_tag = "save-reply"
let view =
  let ul_wrapper (_, comment_tree) =
    let open Cycle.Dom in

    let rec comment_view comment =
      let id = Comment_id.to_int comment.id in
      let id_str = string_of_int id in

      match comment.timestamp with
        | Some ts -> (* This is a saved comment. *)
          h "li.box.comment" ~attrs:[%bs.obj { key = id_str } ] [
            h "span.comment-body" [
              h "strong" [comment.author |> append " " |> text];
              comment.msg |> append " " |> text ];

            h "span.control.has-addons.comment-actions" [
              h ("button#up-" ^ id_str ^ ".button.is-small.up") [
                text "+1" ];

              h ("button#down-" ^ id_str ^ ".button.is-small.down") [
                text "-1" ];

              h "span.button.is-small.is-disabled" [
                datetime_format
                  |> Intl.Date_time_format.format ts
                  |> append " "
                  |> text ];

              h (Printf.sprintf
                  "button#%s-%s.button.is-small.%s"
                  start_reply_tag id_str start_reply_tag) [
                text "Reply" ] ];

              match Ct.children id comment_tree with
                | [] -> text ""
                | replies -> h "ul" (List.map comment_view replies) ]

        (*
        This is an unsaved comment, i.e. it's currently being edited.
        *)
        | None ->
          h "li.box.comment" ~attrs:[%bs.obj { key = id_str } ] [
            h "p.control.comment-body" [
              h (Printf.sprintf
                  "textarea#%s-%s.textarea.%s"
                  edit_reply_tag
                  id_str
                  edit_reply_tag)

                ~attrs:[%bs.obj { _type = "text" } ] [] ];

            h "p.control.has-addons.comment-actions" [
              h (Printf.sprintf
                  "button#%s-%s.button.is-small.%s"
                  save_reply_tag
                  id_str
                  save_reply_tag) [
                text "Send"];

              h (Printf.sprintf
                  "button#%s-%s.button.is-small.%s"
                  cancel_reply_tag
                  id_str
                  cancel_reply_tag) [
                text "Cancel"] ] ] in

    comment_tree
      |> Ct.roots |> List.map comment_view |> h "ul" in

  Xs.map ul_wrapper

let author = "bob"
let actions dom =
  let elem_tag_id id_tag id_str =
    let id_tag_len = String.length id_tag in
    let id_str_len = String.length id_str in

    (id_str_len - id_tag_len - 1)
      |> String.sub id_str (id_tag_len + 1)
      |> int_of_string
      |> Comment_id.of_int in

  let clicked_tagged_ids id_tag =
    dom
      |> Ds.select ("." ^ id_tag)
      |> Ds.events "click"
      |> Xs.map (fun e ->
        let open Web in

        e |> Event.target
          |> Node.of_event_target
          |> Element.of_node
          |> Element.id
          |> elem_tag_id id_tag) in

  Xs.merge4
    (clicked_tagged_ids start_reply_tag
      |> Xs.map (fun i -> Start_reply_to (i, author)))

    (clicked_tagged_ids cancel_reply_tag
      |> Xs.map (fun i -> Cancel_reply i))

    (clicked_tagged_ids save_reply_tag
      |> Xs.map (fun i -> Save_reply i))

    (dom
      |> Ds.select ("." ^ edit_reply_tag)
      |> Ds.events "input"
      |> Xs.map (fun e ->
        let open Web in

        let elem =
          e |> Event.target
            |> Node.of_event_target
            |> Element.of_node in

        let elem_id =
          elem |> Element.id |> elem_tag_id edit_reply_tag in

        let value =
          elem
            |> Html_element.of_element
            |> Html_textarea_element.of_html_element
            |> Html_textarea_element.value in

        Edit_reply (elem_id, value)))

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

