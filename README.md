# pvz.nvim

[![pre-commit.ci status](https://results.pre-commit.ci/badge/github/Freed-Wu/pvz.nvim/main.svg)](https://results.pre-commit.ci/latest/github/Freed-Wu/pvz.nvim/main)
[![github/workflow](https://github.com/Freed-Wu/pvz.nvim/actions/workflows/main.yml/badge.svg)](https://github.com/Freed-Wu/pvz.nvim/actions)

[![github/downloads](https://shields.io/github/downloads/Freed-Wu/pvz.nvim/total)](https://github.com/Freed-Wu/pvz.nvim/releases)
[![github/downloads/latest](https://shields.io/github/downloads/Freed-Wu/pvz.nvim/latest/total)](https://github.com/Freed-Wu/pvz.nvim/releases/latest)
[![github/issues](https://shields.io/github/issues/Freed-Wu/pvz.nvim)](https://github.com/Freed-Wu/pvz.nvim/issues)
[![github/issues-closed](https://shields.io/github/issues-closed/Freed-Wu/pvz.nvim)](https://github.com/Freed-Wu/pvz.nvim/issues?q=is%3Aissue+is%3Aclosed)
[![github/issues-pr](https://shields.io/github/issues-pr/Freed-Wu/pvz.nvim)](https://github.com/Freed-Wu/pvz.nvim/pulls)
[![github/issues-pr-closed](https://shields.io/github/issues-pr-closed/Freed-Wu/pvz.nvim)](https://github.com/Freed-Wu/pvz.nvim/pulls?q=is%3Apr+is%3Aclosed)
[![github/discussions](https://shields.io/github/discussions/Freed-Wu/pvz.nvim)](https://github.com/Freed-Wu/pvz.nvim/discussions)
[![github/milestones](https://shields.io/github/milestones/all/Freed-Wu/pvz.nvim)](https://github.com/Freed-Wu/pvz.nvim/milestones)
[![github/forks](https://shields.io/github/forks/Freed-Wu/pvz.nvim)](https://github.com/Freed-Wu/pvz.nvim/network/members)
[![github/stars](https://shields.io/github/stars/Freed-Wu/pvz.nvim)](https://github.com/Freed-Wu/pvz.nvim/stargazers)
[![github/watchers](https://shields.io/github/watchers/Freed-Wu/pvz.nvim)](https://github.com/Freed-Wu/pvz.nvim/watchers)
[![github/contributors](https://shields.io/github/contributors/Freed-Wu/pvz.nvim)](https://github.com/Freed-Wu/pvz.nvim/graphs/contributors)
[![github/commit-activity](https://shields.io/github/commit-activity/w/Freed-Wu/pvz.nvim)](https://github.com/Freed-Wu/pvz.nvim/graphs/commit-activity)
[![github/last-commit](https://shields.io/github/last-commit/Freed-Wu/pvz.nvim)](https://github.com/Freed-Wu/pvz.nvim/commits)
[![github/release-date](https://shields.io/github/release-date/Freed-Wu/pvz.nvim)](https://github.com/Freed-Wu/pvz.nvim/releases/latest)

[![github/license](https://shields.io/github/license/Freed-Wu/pvz.nvim)](https://github.com/Freed-Wu/pvz.nvim/blob/main/LICENSE)
[![github/languages](https://shields.io/github/languages/count/Freed-Wu/pvz.nvim)](https://github.com/Freed-Wu/pvz.nvim)
[![github/languages/top](https://shields.io/github/languages/top/Freed-Wu/pvz.nvim)](https://github.com/Freed-Wu/pvz.nvim)
[![github/directory-file-count](https://shields.io/github/directory-file-count/Freed-Wu/pvz.nvim)](https://github.com/Freed-Wu/pvz.nvim)
[![github/code-size](https://shields.io/github/languages/code-size/Freed-Wu/pvz.nvim)](https://github.com/Freed-Wu/pvz.nvim)
[![github/repo-size](https://shields.io/github/repo-size/Freed-Wu/pvz.nvim)](https://github.com/Freed-Wu/pvz.nvim)
[![github/v](https://shields.io/github/v/release/Freed-Wu/pvz.nvim)](https://github.com/Freed-Wu/pvz.nvim)

[![luarocks](https://img.shields.io/luarocks/v/Freed-Wu/pvz.nvim)](https://luarocks.org/modules/Freed-Wu/pvz.nvim)

A plants-vs-zombies user file editor based on neovim.

## Dependence

### Build

See [build script](scripts/generate.sh).

- [ksc](https://github.com/kaitai-io/kaitai_struct_compiler)
- perl

```sh
git clone --depth=1 --branch=pvz https://github.com/Freed-Wu/kaitai_struct_formats
scripts/generate.sh
```

## Install

### rocks.nvim

#### Command style

```vim
:Rocks install pvz.nvim
```

#### Declare style

`~/.config/nvim/rocks.toml`:

```toml
[plugins]
"pvz.nvim" = "scm"
```

Then

```vim
:Rocks sync
```

or:

```sh
$ luarocks --lua-version 5.1 --local --tree ~/.local/share/nvim/rocks install pvz.nvim
# ~/.local/share/nvim/rocks is the default rocks tree path
# you can change it according to your vim.g.rocks_nvim.rocks_path
```

### lazy.nvim

```lua
require("lazy").setup {
  spec = {
    { "Freed-Wu/pvz.nvim", lazy = false },
  },
}
```

## Usage

### users.dat

```sh
vi pvz://
```

```csv
id,timestamp,name
1,10,name
```

edit username or `dd` to delete user.

```vim
:wq
```

Then restart game to see changes.

### user1.dat

```sh
vi pvz://id
```

```yaml
# Zen Garden plants
zen_plants:
  - # 豌豆射手
    plant_type: 0
    garden_location: 0
    column: 0
    row: 0
    direction: 0
    last_watered: 0
    color: 0
    times_fertilized: 3
    times_watered: 0
    water_needed: 0
    happiness_state: 0
    last_phono_bugspray: 0
    last_fertilized: 0
    last_chocolate: 0
  - # 向日葵
    plant_type: 1
    garden_location: 0
    column: 1
    row: 0
    direction: 0
    last_watered: 0
    color: 0
    times_fertilized: 3
    times_watered: 0
    water_needed: 0
    happiness_state: 0
    last_phono_bugspray: 0
    last_fertilized: 0
    last_chocolate: 0
```

```vim
:wq
```

Restart game:

```sh
pvz-portable
```

![screenshot](https://github.com/user-attachments/assets/555f9efb-6ab3-4781-b94a-66d0eb685fdb)

[A reference yaml](conf/user.yaml).

Refer <https://plantsvszombies.fandom.com/wiki/User_file_format>.

### main.pak

You can extract plants-vs-zombies's resource package.

```sh
# xor decode
$ pvz xor ~/.config/io.github.wszqkzqk/PvZPortable/main.pak
# extract
$ pvz unpak ~/.config/io.github.wszqkzqk/PvZPortable/main.pak.xor
$ ls ~/.config/io.github.wszqkzqk/PvZPortable/main
 compiled   data   images   particles   properties   reanim   sounds
```

## Related Projects

- [plants-vs-zombies-user-file-editor](https://github.com/chiaracoetzee/plants-vs-zombies-user-file-editor):
  written in C#
