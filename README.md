# TODO-CLI

I started this project as a pet project to learn Rust but also how do Python and Rust interact with each other.

I plan to document this in a series of blogs as well as in this repository itself.

## The app

- CLI app to manage to do tasks lists
- Tasks are grouped to form projects
- Tasks and projects are locally persisted using yaml (and markdown?)
- Tasks and projects can be updated and each change gets logged
- Nice-to-have: Render a kanban TUI

## Roadmap

- [ ] Rust-python barebones
  - [ ] Rust entrypoint
  - [ ] Call python code from rust
  - [ ] Compile a single binary
- [ ] Build the To-Do app in python
  - [ ] Create tasks
  - [ ] Create projects
  - [ ] List tasks
  - [ ] Filter tasks per project
  - [ ] Log to tasks
  - [ ] Update tasks
  - [ ] Update project
  - [ ] All logs in tasks should be logged to parent project as well
- [ ] Progressively port it to Rust
- [ ] Remove python code base
- [ ] Nice-to-haves
  - [ ] Kanban TUI
  - [ ] Reporting
  - [ ] Notifications
  - [ ] Obsidian integration
