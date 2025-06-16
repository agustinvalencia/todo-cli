from typer import Typer

app = Typer(no_args_is_help=True)


@app.command()
def hello(name: str):
    print(f"Hello {name}")


def main():
    app()


if __name__ == "__main__":
    main()
