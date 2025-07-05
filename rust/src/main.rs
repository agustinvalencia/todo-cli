use pyo3::prelude::*;

// fn main() -> PyResult<()> {
//     // IMPORTANT: This Rust program relies on the Python virtual environment
//     // being active in the shell where you run `cargo run`.
//     //
//     // Before running, make sure you are in your Python project's directory
//     // and have activated the environment:
//     //
//     // On Linux/macOS: `source .venv/bin/activate`
//     // On Windows:      `.venv\Scripts\activate`
//     //
//     // This sets the necessary environment variables (like VIRTUAL_ENV and PATH)
//     // so that PyO3 can find the correct Python interpreter and your installed
//     // 'todo' package.
//
//     // PyO3 will automatically use the Python interpreter from the active
//     // virtual environment. The GIL is acquired here.
//     Python::with_gil(|py| {
//         println!("--- Rust: Attempting to run Python entry point 'todo.main:main' ---");
//
//         // The script "todo = 'todo.main:main'" means we need to import the module 'todo.main'.
//         // PyO3's import mechanism will find it because your `uv` environment is active.
//         let main_module = py.import_bound("todo.main")?;
//
//         // From that module, we get a handle to the 'main' function.
//         let main_func = main_module.getattr("main")?;
//
//         // Now, we call the function. We use `call0` because we are not passing
//         // any command-line arguments, just running the entry point directly.
//         // Your Python code will print "hola".
//         main_func.call0()?;
//
//         println!("--- Rust: Python entry point finished ---");
//
//         // Return Ok to indicate success.
//         Ok(())
//     })
// }

fn main() -> PyResult<()> {
    Python::with_gil(|py| {
        println!(" -- Rust: Attempting to reach python --");
        let main_module = py.import("todo.main")?;
        let main_func = main_module.getattr("main")?;
        main_func.call0()?;
        println!(" -- Rust: python call finished--");
        Ok(())
    })
}
