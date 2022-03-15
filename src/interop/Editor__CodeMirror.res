type extension

module EditorState = {
  type conf = {doc: string, extensions: array<extension>}
  type t

  @module("@codemirror/state") @scope("EditorState")
  external make: conf => t = "create"
}

module EditorView = {
  type conf = {state: EditorState.t, parent: Dom.element}
  //  type keymap
  type t

  //  @module("@codemirror/view")
  //  external keymap: keymap = "keymap"
  //
  //  @send
  //  external of_: (keymap, keymap) => extension = "of"

  @module("@codemirror/view") @new
  external make: conf => t = "EditorView"
}

//@module("@codemirror/commands")
//external
