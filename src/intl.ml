module Date_time_format = struct
  type t

  type repr_width = [`narrow | `short | `long] [@bs.string]
  type num_width =
    [`numeric | `two_digit [@bs.as "2-digit"]] [@bs.string]

  module Options = struct
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

  external make' : string array -> Options.t -> t =
    "Intl.DateTimeFormat" [@@bs.new]

  let make ?(options=Options.make ()) locales =
    make' (Array.of_list locales) options
end

