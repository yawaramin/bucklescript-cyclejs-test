type t =
  { id : int;
    reply_to : t option;
    timestamp : Js_date.t;
    author : string;
    msg : string }

let init_id = 0
let incr_id old_id = old_id + 1

let make id ?reply_to author msg =
  { id; reply_to; timestamp = Js_date.now (); author; msg }

let id t = t.id
let reply_to t = t.reply_to
let timestamp t = t.timestamp
let author t = t.author
let msg t = t.msg
let append_colon string = string ^ ": "
let view t =
  let open Cycle_dom in
  let comment_id = t |> id |> string_of_int in

  h "li.box" ["key", comment_id] [
    h "p.block" [] [
      text "2017-01-01T16:01Z ";
      h "strong" [] [t |> author |> append_colon |> text];
      t |> msg |> text ];

    h "p.control.has-addons" [] [
      h ("a#up-" ^ comment_id ^ ".button.up") [] [text "+1"];
      h ("a#reply-" ^ comment_id ^ ".button.reply") [] [text "Reply"];
      h ("a#down-" ^ comment_id ^ ".button.is-danger.down") [] [
        text "-1"] ] ]

