type t

external now : unit -> t = "Date" [@@bs.new]
val ymdhms : int -> int -> int -> int -> int -> int -> t
val make :
  ?year:int ->
  ?month:int ->
  ?date:int ->
  ?hours:int ->
  ?minutes:int ->
  ?seconds:int ->
  ?milliseconds:int ->
  unit ->
  t
