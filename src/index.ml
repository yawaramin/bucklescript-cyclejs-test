let main _ =
  let _ = Bulma.bulma in

  [%bs.obj
    { dom =
        Comment.init_comment
          |> Xstream.singleton
          |> Xstream.remember
          |> Memory_stream.map Comment.view } ]

let () =
  let app_id = "app" in

  [%bs.obj { dom = Cycle.Dom.make_dom_driver ("#" ^ app_id) }]
    |> Cycle.Xstream_run.run main |> ignore

