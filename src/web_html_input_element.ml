type t

external of_html_element : Web_html_element.t -> t = "%identity"
external value : t -> string = "" [@@bs.get]

