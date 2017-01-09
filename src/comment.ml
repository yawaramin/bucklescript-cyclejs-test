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
    h "div" ["class", "box"] [
      h "article" ["class", "media"] [
        h "div" ["class", "media-content"] [
          h "div" ["class", "content"] [
            h "strong" ~text:(author t) [] [];
            h "span" ~text:" - 2017-01-01T16:01Z -" [] [];
            h "span" ~text:(msg t) [] [] ];

          h "nav" ["class", "level"] [
            h "div" ["class", "level-left"] [
              h "a" ~text:"Reply" ["class", "level-item button"] [] ] ] ] ] ])

