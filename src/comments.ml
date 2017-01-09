type t = { comment : Comment.t; replies : t list }

let make id ?reply_to author msg =
  { comment = Comment.make id ?reply_to author msg; replies = [] }

let comment t = t.comment
let replies t = t.replies

let start id author msg = make id author msg

let reply id author msg t =
  let comment = make id ~reply_to:t.comment author msg in
  { t with replies = comment :: t.replies }

let init_comment = start Comment.init_id "bob" "Test comment"

let view t = t |> comment |> Comment.view

