# MyGit (the GIT at home)

MyGit is a barebones Git implementation built as a learning exercise. MyGit so far has three rudimentary Git functionalities: 

- `mygit_init` - initialising a mygit repo
- `mygit_add` - adding files
- `mygit_commit` - commiting files

## Overview

`bin/mygit` is our entry-point executable for parsing and executing mygit commands and args. 

*
- `.mygit/objects/info` and `.mygit/objects/pack` yet to be utilised.

### bin/mygit_init

This command initialises a new MyGit repository by creating the `.mygit` directory and its initial structure:

```
.mygit
├── HEAD
├── objects
│  ├── info
│  └── pack
└── refs
    ├── heads
    └── tags
```

- `HEAD`: Points to the current branch
- `.mygit/objects/`: Stores object files (blobs, trees, commits)
- `.mygit/refs/`: Stores references (branches, tags)

### bin/mygit_add <filepath>

Stages a file for commit. For example, `bin/mygit_add bin/mygit` will create an object file and update the index:

```
.mygit
├── HEAD
├── index
├── objects
│   ├── ae
│   │   └── e8e36f65a8845162561692d123daf23d59a686
│   ├── info
│   └── pack
└── refs
├── heads
└── tags
```

The `index` file will contain information about the staged files. A simplified view might look like:

`aee8e36f65a8845162561692d123daf23d59a686 bin/mygit`


### bin/mygit_commit

Creates a new commit object with the current state of the index, and after a few stagings and commits, the .mygit structure might look like follows:

```
.mygit
├── COMMIT_EDIT_MESSAGE
├── HEAD
├── index
├── objects
│   ├── ae
│   │   └── e8e36f65a8845162561692d123daf23d59a686
│   ├── c4
│   │   └── 4b1a1f7c58d2f3e041bfc1e4c819c9a6f9c2b8a4
│   ├── 62
│   │   └── 161568392ed9aa321466446a9bb01acb111e4f
│   ├── b3
│   │   └── 9f81a3b2c49f27d6f8e13a5f6e0a8d1b7c9f5a2b
│   ├── 12
│   │   └── 7a4e5b3d2c1f8e4a6b7c9d1a2f3e8b9c0d7e1f2a
│   ├── info
│   └── pack
└── refs
├── heads
│   └── main
└── tags
```

- `COMMIT_EDIT_MESSAGE`: Temporary file for commit messages
- Objects in `.mygit/objects/` Represent various Git objects (blobs, trees, commits)
- `refs/heads/main`: Points to the latest commit on the main branch

Note: The object hashes and directory names are examples and will differ based on actual content.

**To note ⚠️:** Object directories in `.mygit/objects/` are named with the first two characters of the object hash

Will also implement config, .gitignore, and README files creation option feature likely, although project scope met.

### Todos

- [ ] commit reconciled to branch
- [ ] config and .gitignore files
- [ ] README init creation option template
