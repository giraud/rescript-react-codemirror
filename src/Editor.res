module State = {
  @module("../../../src/interop/Editor__NodeTypes") @react.component
  external make: (~extensions: array<Editor__CodeMirror.extension>) => React.element = "State"
}

module Edge = {
  @module("../../../src/interop/Editor__NodeTypes") @react.component
  external make: (
    ~source: string,
    ~target: string,
    ~label: string=?,
    ~onClick: ReactEvent.Mouse.t => unit=?,
  ) => React.element = "Edge"
}

module Map = {
  @module("../../../src/interop/Editor__NodeTypes") @react.component
  external make: (~className: string=?) => React.element = "Map"
}

type extension = Editor__CodeMirror.extension

@react.component
let make = (
  ~width,
  ~height,
  ~className=?,
  ~extensions: array<Editor__CodeMirror.extension>,
  ~children,
) => {
  let diagramNode = React.useRef(None)
  /*
  let canvasNode = React.useRef(None)
  let slidingEnabled = React.useRef(false)
  let selectingEnabled = React.useRef(false)
  let selectionBox = React.useRef(None)

  React.useEffect1(() => {
    switch diagramNode.current {
    | Some(container) =>
      container
      ->Editor__Layout.get
      ->Editor__Layout.registerListener(onLayoutUpdate->Belt.Option.getWithDefault(() => ()))
      onLayoutUpdate->Belt.Option.forEach(fn => fn())
    | None => ()
    }
    None
  }, [onLayoutUpdate])

  switch diagramNode.current {
  | Some(container) => container->Editor__Layout.get->Editor__Layout.setOrientation(orientation)
  | None => ()
  }
 */
  let initRender = domNode => {
    diagramNode.current = domNode->Js.toOption
    switch diagramNode.current {
    | Some(container) =>
      //      open Belt.Option
      //      canvasNode.current = container->Editor__Dom.firstChild->Js.toOption
      Editor__DOMRenderer.render(children, container, () => {
        //        let update = (changeScale, center, ()) => {
        // compute center
        //          let (x, y, scale) = if center {
        //            let (canvasWidth, canvasHeight) = t->Editor__Transform.getBBox
        //            if canvasWidth > 0. && canvasHeight > 0. {
        //              let {width: containerWidth, height: containerHeight} =
        //                container->Editor__Dom.getBoundingClientRect
        //               change scale if wanted
        //              let scale = if changeScale {
        //                let realScale =
        //                  0.98 /.
        //                  Js.Math.max_float(canvasWidth /. containerWidth, canvasHeight /. containerHeight)
        //                Js.Math.min_float(1.0, Js.Math.max_float(minScale, realScale))
        //              } else {
        //                t->Editor__Transform.scale
        //              }
        //
        //              let x = containerWidth /. 2. -. scale *. (canvasWidth /. 2.)
        //              let y = containerHeight /. 2. -. scale *. (canvasHeight /. 2.)
        //              (x, y, scale)
        //            } else {
        //              (0., 0., 1.)
        //            }
        //          } else {
        //            (0., 0., 1.)
        //          }

        //          t->Editor__Transform.update((x, y), scale)
        //          canvasNode.current->forEach(canvas => canvas->Editor__Dom.setTransform(x, y, scale))
        //        }
        //        l->Editor__Layout.setDisplayBBox(boundingBox)
        //        l->Editor__Layout.setOrientation(orientation)
        //        onCreation->forEach(fn =>
        //          fn(Editor__DomRenderer.Commands.make(update(true, false), update(true, true)))
        //        )
        open Editor__CodeMirror
        let startState = EditorState.make({
          doc: "hello world",
          extensions: extensions,
        })
        let _view = EditorView.make({state: startState, parent: container})
      })
    | None => ()
    }
  }

  <div
    ref={ReactDOM.Ref.callbackDomRef(initRender)}
    ?className
    style={ReactDOM.Style.make(~width, ~height, ~position="relative", ~overflow="hidden", ())}>
    <div style={ReactDOM.Style.make(~position="relative", ~transformOrigin="0 0", ())} />
  </div>
}
