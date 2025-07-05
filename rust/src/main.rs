use pyo3::prelude::*;

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
