type t

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
