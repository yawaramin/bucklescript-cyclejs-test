type t

module Options : sig
  type repr_width = [`narrow | `short | `long] [@bs.string]
  type num_width =
    [`numeric | `two_digit [@bs.as "2-digit"]] [@bs.string]

  type t

  external make :
    ?locale_matcher:
      ([`lookup | `best_fit [@bs.as "best fit"]] [@bs.string]) ->

    ?time_zone:string ->
    ?hour12:bool ->
    ?format_matcher:
      ([`basic | `best_fit [@bs.as "best fit"]] [@bs.string]) ->

    ?weekday:repr_width ->
    ?era:repr_width ->
    ?year:num_width ->
    ?month:
      ([`narrow |
        `short |
        `long |
        `numeric |
        `two_digit [@bs.as "2-digit"]] [@bs.string]) ->

    ?day:num_width ->
    ?hour:num_width ->
    ?minute:num_width ->
    ?second:num_width ->
    ?time_zone_name:([`short | `long] [@bs.string]) ->
    unit ->
    t =
    "" [@@bs.obj]
 end

val make : ?options:Options.t -> ?locales:string list -> unit -> t
external format : Js_date.t -> string = "" [@@bs.send.pipe: t]

