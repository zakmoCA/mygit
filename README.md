# MyGit (the GIT at home)

MyGit is a barebones Git implementation built as a learning exercise. MyGit implements the core concepts of Git's content-addressable storage system with three rudimentary Git functionalities:

- `mygit_init` - initialising a mygit repo
- `mygit_add` - adding files
- `mygit_commit` - commiting files

## Implementation

MyGit now properly implements several Git concepts:

- **Content-addressable storage**: Files are stored based on SHA1 hash of their content
- **Object types**: Supports blob (file), tree (directory), and commit objects
- **Proper Git headers**: Object storage includes type and size headers
- **Compressed storage**: All objects are zlib-compressed
- **Parent commit tracking**: Commits reference their parents for history


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

Stages a file for commit. For example, `bin/mygit_add README.md` will:
1. Calculate the SHA1 hash of the file with proper headers
2. Store the compressed content as a blob object
3. Update the index with the file's path and hash

```
.mygit
├── HEAD
├── index
├── objects
│   ├── 5b
│   │   └── 6c2e3f7d8a9b0c1d2e3f4a5b6c7d8e9f0a1b2c3
│   ├── info
│   └── pack
└── refs
├── heads
└── tags
```

The `index` file will contain information about the staged files:

`5b6c2e3f7d8a9b0c1d2e3f4a5b6c7d8e9f0a1b2c3 README.md`

### bin/mygit_commit

Creates a new commit object with the current state of the index by:
1. Building tree objects for the directory structure
2. Opening an editor for the commit message
3. Creating a commit object with references to the tree and parent
4. Updating the current branch to point to the new commit

After a few stagings and commits, the .mygit structure might look like:

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

**To note ⚠️:** Object directories in `.mygit/objects/` are named with the first two characters of the object hash

## Usage

```bash
# init a repo
bin/mygit init

# add files to staging
bin/mygit add <filename>

# commit staged
bin/mygit commit
```

## Reamining Todos

- [ ] README init creation option template
- [ ] branch creation and management
- [ ] checkout/merge functionality
- [ ] log command for viewing history