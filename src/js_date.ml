type t

external now : unit -> t = "Date" [@@bs.new]
external ym : int -> int -> t = "Date" [@@bs.new]
external ymd : int -> int -> int -> t = "Date" [@@bs.new]
external ymdh : int -> int -> int -> int -> t = "Date" [@@bs.new]
external ymdhm : int -> int -> int -> int -> int -> t =
  "Date" [@@bs.new]

external ymdhms : int -> int -> int -> int -> int -> int -> t =
  "Date" [@@bs.new]

external ymdhmsms : int -> int -> int -> int -> int -> int -> int -> t =
  "Date" [@@bs.new]

let make ?year ?month ?date ?hours ?minutes ?seconds ?milliseconds () =
  match year, month, date, hours, minutes, seconds, milliseconds with
    | None, None, None, None, None, None, None -> now ()
    | Some year', Some month', None, None, None, None, None ->
      ym year' month'

    | Some year', Some month', Some date', None, None, None, None ->
      ymd year' month' date'

    | Some year',
      Some month',
      Some date',
      Some hours',
      None,
      None,
      None ->
      ymdh year' month' date' hours'

    | Some year',
      Some month',
      Some date',
      Some hours',
      Some minutes',
      None,
      None ->
      ymdhm year' month' date' hours' minutes'

    | Some year',
      Some month',
      Some date',
      Some hours',
      Some minutes',
      Some seconds',
      None ->
      ymdhms year' month' date' hours' minutes' seconds'

    | Some year',
      Some month',
      Some date',
      Some hours',
      Some minutes',
      Some seconds',
      Some milliseconds' ->
      ymdhmsms year' month' date' hours' minutes' seconds' milliseconds'

    | _ -> failwith "Invalid date"
