type t =
  { id : int;
    parent_id : int option;
    timestamp : Js_date.t;
    author : string;
    msg : string }

let init_id = 0
let incr_id old_id = old_id + 1

let make id ?parent_id author msg =
  { id; parent_id; timestamp = Js_date.now (); author; msg }

let id t = t.id
let parent_id t = t.parent_id
let timestamp t = t.timestamp
let author t = t.author
let msg t = t.msg
let view t =
  Cycle_dom.(
    h "div.box" [] [
      h "article.media" [] [
        h "div.media-content" [] [
          h "div.content" [] [
            h "strong" ~text:(author t) [] [];
            h "span" ~text:" - 2017-01-01T16:01Z -" [] [];
            h "span" ~text:(msg t) [] [] ];

          h "nav.level" [] [
            h "div.level-left" [] [
              h "a.level-left.button" ~text:"Reply" [] [] ] ] ] ] ])

