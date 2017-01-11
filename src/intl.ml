module Date_time_format = struct
  type t

(*
Shelving this type-safe object creator until
https://github.com/bloomberg/bucklescript/issues/1072 is resolved.
*)
(*
  module Options = struct
    type repr_width = [`narrow | `short | `long] [@bs.string]
    type num_width =
      [`numeric | `two_digit [@bs.as "2-digit"]] [@bs.string]

    type t

    external make :
      ?locale_matcher:
        ([`lookup | `best_fit [@bs.as "best fit"]] [@bs.string]) ->

      ?time_zone:string ->
      ?hour12:Js.boolean ->
      ?format_matcher:
        ([`basic | `best_fit [@bs.as "best fit"]] [@bs.string]) ->

      ?weekday:repr_width ->
      ?era:repr_width ->
      ?year:num_width ->
      ?month:([repr_width | num_width ] [@bs.string]) ->
      ?day:num_width ->
      ?hour:num_width ->
      ?minute:num_width ->
      ?second:num_width ->
      ?time_zone_name:([`short | `long] [@bs.string]) ->
      unit ->
      t =
      "" [@@bs.obj]
  end
*)

  external empty_obj : 'a = "" [@@bs.obj]
  external make' : string array Js.undefined -> 'a -> t =
    "Intl.DateTimeFormat" [@@bs.new]

  let make ?(options=empty_obj) ?(locales=[]) () =
    let locales', options' =
      match locales with
        | [] -> Js.undefined, Js.undefined
        | _ ->
          Js.Undefined.return (Array.of_list locales),
          Js.Undefined.return options in

    make' locales' options'

  external format : Js_date.t -> string = "" [@@bs.send.pipe: t]
end

