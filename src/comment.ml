type t =
  { id : int;
    reply_to : t option;
    replies : t list;
    timestamp : Js_date.t;
    author : string;
    msg : string }

let incr_id old_id = old_id + 1

let make id ?reply_to ?(replies=[]) author msg =
  { id; reply_to; replies; timestamp = Js_date.make (); author; msg }

let id t = t.id
let reply_to t = t.reply_to
let replies t = t.replies
let timestamp t = t.timestamp
let author t = t.author
let msg t = t.msg

let reply t to_t = { to_t with replies = t :: replies to_t }
let append suffix to_string = to_string ^ suffix
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

let has_replies t = match replies t with [] -> false | _ -> true
let rec view t =
  let open Cycle_dom in
  let comment_id = t |> id |> string_of_int in

  h "li.box" ~attrs:[%bs.obj { key = comment_id } ] [
    h "p.block" [
      datetime_format
        |> Intl.Date_time_format.format (timestamp t)
        |> append " "
        |> text;

      h "strong" [t |> author |> append ": " |> text];
      t |> msg |> text ];

    h "p.control.has-addons" [
      h ("a#reply-" ^ comment_id ^ ".button.reply") [text "Reply"];
      h ("a#up-" ^ comment_id ^ ".button.up") [text "+1"];
      h ("a#down-" ^ comment_id ^ ".button.down") [text "-1"] ];

    if has_replies t
      then h "ul" (t |> replies |> List.map view) else text "" ]

let init_comment =
  make 0 ~replies:[make 1 "jim" "Test reply."] "bob" "Test comment"
