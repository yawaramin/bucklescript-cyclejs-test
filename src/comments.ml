type t = { comment : Comment.t; replies : t list }

let make id ?parent_id author msg =
  { comment = Comment.make id ?parent_id author msg; replies = [] }

let comment t = t.comment
let replies t = t.replies

let start id author msg = make id author msg

let reply id author msg t =
  let comment = make id ~parent_id:(Comment.id t.comment) author msg in
  { t with replies = comment :: t.replies }

let init_comment = start Comment.init_id "bob" "Hello, World!"

