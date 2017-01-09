open Cycle_dom

let main _ =
  [%bs.obj
    { dom =
        Comments.init_comment
          |> Xstream.singleton
          |> Xstream.remember
          |> Memory_stream.map Comments.view } ]

let () =
  let app_id = "app" in

  [%bs.obj { dom = make_dom_driver ("#" ^ app_id) }]
    |> Cycle_xstream_run.run main
    |> ignore

