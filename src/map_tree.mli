type 'a t
exception Id_zero_invalid

val empty : 'a t

(**
`add ~parent_id:pid id a t` returns a new tree with the node `a` added
to the tree `t` with ID `id` and as a child node of the node `pid`. If
`parent_id` isn't specified, the added node is assumed to be a root
node.

Raises exception `Id_zero_invalid` if `id` is 0.
*)
val add : ?parent_id:int -> int -> 'a -> 'a t -> 'a t
val children : int -> 'a t -> 'a list
val roots : 'a t -> 'a list

(**
`remove id t` removes not just the element with ID `id` from the tree
`t` but all its children, recursively, and returns an updated tree.
Not tail-recursive.
*)
val remove : int -> 'a t -> 'a t

(**
`graft ~parent_id:pid id t` returns a new tree with the node with ID
`id` and its entire subtree grafted into a new location as a child of
the node with ID `pid`. If `parent_id` isn't specified, the grafted node
is made a root node.
*)
val graft : ?parent_id:int -> int -> 'a t -> 'a t

(**
`update id f t` returns a new tree with the update function `f`
applied to the element with ID `id` in the old tree. Note that `update`
doesn't know if you change the element's ID or parent ID in the update
function, so that has no effect. If you want to move an element (and its
subtree) to a new place in the tree, use `graft`.
*)
val update : int -> ('a -> 'a) -> 'a t -> 'a t

