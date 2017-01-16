type t =
  { id : int;
    reply_to : int option;
    replies : t list;
    timestamp : Js_date.t;
    author : string;
    msg : string }

type ('a, 'b) sources = < dom : ('a, 'b) Cycle.Dom.Source.t > Js.t
type sinks =
  < dom : Cycle.Dom.vnode Memory_stream.t;
    numComments : int Memory_stream.t;
    comments : t Memory_stream.t > Js.t

let incr_id old_id = old_id + 1

let make
  id
  ?reply_to
  ?(replies=[])
  ?(timestamp = Js_date.make ())
  author
  msg =
  { id; reply_to; replies; timestamp; author; msg }

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

external style : 'a = "style!../../css/src/comment.css" [@@bs.module]
let has_replies t = match replies t with [] -> false | _ -> true

let view t =
  let open Cycle.Dom in
  let _ = style in
  let rec aux is_top t =
    let comment_id = t |> id |> string_of_int in
    let comment_li =
      h "li.box.comment" ~attrs:[%bs.obj { key = comment_id } ] [
        h "span.comment-body" [
          h "strong" [t |> author |> append " " |> text];
          t |> msg |> append " " |> text];

        h "span.control.has-addons.comment-actions" [
          h ("a#reply-" ^ comment_id ^ ".button.is-small.reply") [
            text "Reply" ];

          h ("a#up-" ^ comment_id ^ ".button.is-small.up") [text "+1"];
          h ("a#down-" ^ comment_id ^ ".button.is-small.down") [
            text "-1" ];

          h "span.button.is-small.is-disabled" [
            datetime_format
              |> Intl.Date_time_format.format (timestamp t)
              |> append " "
              |> text ] ];

        if has_replies t
          then h "ul" (t |> replies |> List.map (aux false))
          else text "" ] in

    if is_top then h "ul" [comment_li] else comment_li in

  aux true t

let init_comment =
  let c id timestamp ?reply_to author msg replies =
    make id ?reply_to ~replies ~timestamp author msg in

  c 0
    (Js_date.ymdhms 2017 0 4 21 8 57)
    "semi_colon"
    "As someone who doesn't use Go or Python: what is the use for this?"
    [ c 1
        (Js_date.ymdhms 2017 0 4 21 23 20)
        ~reply_to:0
        "vplatt"
        "To run Python code as a Go compiled executable. This allows them to avoid the Python Global Interpreter Lock (which severely limits Python\'s scalability within a single process) and run the Python code using Go modules as if they were Python modules.

Really, unless you're Google or another Python shop interesting in moving to Go, you probably don't have a use for this."
        [ c 2
            (Js_date.ymdhms 2017 0 4 22 40 49)
            ~reply_to:1
            "semi_colon"
            "Thanks, great explanation."
            [];

          c 3
            (Js_date.ymdhms 2017 0 4 23 22 24)
            ~reply_to:1
            "VodkaHaze"
            "Getting around the GIL is a huge step. Python's chief weakness is lack of parallel scalability, IMO. Most solutions around this (joblib, dask, etc.) don't feel like complete solutions. Not when, for example, in C++ or Julia you can slap a macro above a loop to make it instantly parallel."
            [ c 4
                (Js_date.ymdhms 2017 0 4 23 32 58)
                ~reply_to:3
                "CSI_Tech_Dept"
                "It doesn't need GIL, because it offers subset of functionality that python has. It is not even capable of compiling all python standard library.

This code is for Google to move away from python. They can include python libraries in their go code and then one by one rewrite it in go."
                [];

              c 5
                (Js_date.ymdhms 2017 0 4 23 32 18)
                ~reply_to:3
                "theseoafs"
                "For the record, this is not a complete solution either. Grumpy is a tool that compiles a single Python file (no real module support) while eschewing most of Python's dynamic features and supporting very little of its standard library."
                [] ];

          c 6
            (Js_date.ymdhms 2017 0 4 23 31 47)
            ~reply_to:1
            "MightyCreak"
            "Does this mean that you can't interpret two Python scripts at the same time because of GIL, but once interpreted, they can run in parallel?"
            [] ] ]

let main sources =
  let memory_stream x =
    x |> Cycle_xstream.singleton |> Cycle_xstream.remember in

  let comments = memory_stream init_comment in

  [%bs.obj
    { dom = Memory_stream.map view comments;
      numComments = memory_stream 1;
      comments } ]

