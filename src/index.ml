let () =
  let _ = Bulma.bulma in
  let app_id = "app" in

  [%bs.obj { _DOM = Cycle.Dom.make_dom_driver ("#" ^ app_id) }]
    |> Cycle.Xstream_run.run Comment.main |> ignore

