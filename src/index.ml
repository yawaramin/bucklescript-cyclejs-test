open Cycle_dom

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

  [%bs.obj { dom = make_dom_driver ("#" ^ app_id) }]
    |> Cycle_xstream_run.run main |> ignore

