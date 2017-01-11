module Date_time_format : sig
  type t

  (**
  Returns a JavaScript `Intl.DateTimeFormat` object. see
  https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/DateTimeFormat
  for details.

  @param options is ignored if `locales` is an empty list.
  *)
  val make : ?options:'a -> ?locales:string list -> unit -> t
end

