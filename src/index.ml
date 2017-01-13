let main sources =
  let _ = Bulma.bulma in

  [%bs.obj
    { dom =
        Comment.init_comment
          |> Cycle_xstream.singleton
          |> Cycle_xstream.remember
          |> Memory_stream.map (Comment.view sources##dom) } ]

let () =
  let app_id = "app" in

  [%bs.obj { dom = Cycle.Dom.make_dom_driver ("#" ^ app_id) }]
    |> Cycle.Xstream_run.run main |> ignore

