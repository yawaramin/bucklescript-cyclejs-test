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
let view t =
  let open Cycle_dom in
  let comment_id = t |> id |> string_of_int in

  h "div.box" ["key", comment_id] [
    h "article.media" [] [
      h "div.media-content" [] [
        h "div.content" [] [
          h "strong" [] [t |> author |> text];
          text " - 2017-01-01T16:01Z -";
          t |> msg |> text ];

        h "nav.level" [] [
          h "div.level-left" [] [
            h ("a#reply-" ^ comment_id ^ ".button.level-left")
              []
              [text "Reply"] ] ] ] ] ]

