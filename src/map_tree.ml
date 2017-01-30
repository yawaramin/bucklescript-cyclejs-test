module Coords_map = Map.Make(struct
  type t = int * int

  let compare (x1, y1) (x2, y2) =
    match compare x1 x2 with 0 -> compare y1 y2 | c -> c
end)

type 'a t = 'a Coords_map.t
exception Id_zero_invalid

let empty = Coords_map.empty
let add ?(parent_id=0) id a t =
  if id = 0 then raise Id_zero_invalid;
  Coords_map.add (parent_id, id) a t

let children_bindings id t =
  Coords_map.(t |> filter (fun (p, _) _ -> p = id) |> bindings)

let children id t = t |> children_bindings id |> List.map snd
let roots t = children 0 t
let parent id t =
  let result = ref None in
  let store_parent_id (p, i) _ =
    if i = id then (result := Some p; true) else false in

  t |> Coords_map.exists store_parent_id |> ignore;
  match !result with Some r -> r | None -> raise Not_found

let rec remove id t =
  let remove_id t id = remove id t in
  let t = Coords_map.remove (parent id t, id) t in
  let children_ids =
    t |> children_bindings id |> List.map (fun ((_, i), _) -> i) in

  List.fold_left remove_id t children_ids

let graft ?(parent_id=0) id t =
  let p = parent id t in
  let a = Coords_map.find (p, id) t in

  t |> Coords_map.remove (p, id) |> Coords_map.add (parent_id, id) a

let update id f t =
  let p = parent id t in
  t |> Coords_map.add (p, id) (t |> Coords_map.find (p, id) |> f)

