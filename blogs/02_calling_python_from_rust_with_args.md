# Calling Python from Rust : Sending args and getting results back

Previous settings set the foundations for naively bouncing between both code bases. It's naive in the sense that it is only meant to set the piping through which the data should flow. Nonetheless, there is not "talking and answering" yet, let's try to do so.

Recap from previous step, we managed to call a python module from a rust code bases, let's copy the diagram from the first blog:

```mermaid
sequenceDiagram
participant run as Runner
participant cargo as Cargo
participant rust as Rust Source
participant pyinterp as PythonInterpreter
participant python as Python Source

run ->> pyinterp: activate venv
run ->> cargo: compile & run

cargo ->> rust: compile time
note over rust: compiling ...
rust -->> cargo: ok

cargo ->> rust: run time
rust ->> pyinterp: get GIL
note over pyinterp: fail if venv deactivated
pyinterp -->> rust:

rust ->> pyinterp: import todo.main
pyinterp ->> python: import todo.main
python -->> pyinterp :
pyinterp -->> rust :

rust ->> pyinterp: call_function(todo.main)
pyinterp ->> python: todo.main()

note over python: print("hola")

python -->> pyinterp :
pyinterp -->> rust :
```
