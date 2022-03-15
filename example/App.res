%%raw(`import '../../../example/App.css'`)

@val @scope("document")
external getElementById: string => Js.nullable<Dom.element> = "getElementById"

@module("@codemirror/basic-setup")
external basicSetup: Editor.extension = "basicSetup"

let sample1 = "let x = 1;"

module App = {
  @react.component
  let make = () => {
    <main>
      <div className="toolbar">
        <a href="https://github.com/giraud/rescript-react-codemirror"> {"Github"->React.string} </a>
      </div>
      <Editor className="editor" width="100%" height="100%" extensions={[basicSetup]}>
        {"xxx"->React.string}
      </Editor>
    </main>
  }
}

switch getElementById("root")->Js.toOption {
| Some(root) => ReactDOM.render(<React.StrictMode> <App /> </React.StrictMode>, root)
| None => ()
}
