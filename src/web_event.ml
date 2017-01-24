module Target = Web_event_target

type t

external target : t -> Target.t = "" [@@bs.get]

