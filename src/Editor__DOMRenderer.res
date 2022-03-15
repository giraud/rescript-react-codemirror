module DataNodeReactRoot = {
  @set external attach: (Dom.element, 'a) => unit = "_reactRootContainer"
  @get external detach: Dom.element => Js.nullable<'a> = "_reactRootContainer"
}

module Commands = {
  type t = {reset: unit => unit, fitToView: unit => unit}

  let make = (resetFn, fitToViewFn) => {
    reset: resetFn,
    fitToView: fitToViewFn,
  }
}

let render = (element, container, onCreation) => {
  let root = switch container->DataNodeReactRoot.detach->Js.toOption {
  | Some(node) => node
  | None =>
    // Clear canvas
    container->Editor__Dom.forFirstChild(canvas =>
      canvas
      ->Editor__Dom.children
      ->Belt.Array.forEach(node => container->Editor__Dom.removeChild(node))
    )

    let newRoot = Editor__DOMReconciler.reconciler.createContainer(. container)
    //    let transform = Editor__Transform.make()
    //    let layout = Editor__Layout.make()

    container->DataNodeReactRoot.attach(newRoot)
    //    container->Editor__Transform.attach(transform)
    //    container->Editor__Layout.attach(layout)

    onCreation()

    newRoot
  }

  Editor__DOMReconciler.reconciler.updateContainer(. element, root, Js.Nullable.null, None)
}
