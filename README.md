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

See <./scripts/generate.sh>.

- [ksc](https://github.com/kaitai-io/kaitai_struct_compiler)
- perl

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

edit username or `dd` to delete user. `:w` to save.

### user1.dat

```sh
vi pvz://id
```

```yaml
---
adventure_level: 51
money_div_10: 0
adventure_completed_times: 0
# Survival flags (normal)
survival_day_flags: 0
survival_night_flags: 0
survival_pool_flags: 0
survival_fog_flags: 0
survival_roof_flags: 0
# Survival flags (hard)
survival_day_hard_flags: 0
survival_night_hard_flags: 0
survival_pool_hard_flags: 0
survival_fog_hard_flags: 0
survival_roof_hard_flags: 0
# Survival endless streaks
streak_day_endless: 0
streak_night_endless: 0
streak_pool_endless: 0
streak_fog_endless: 0
streak_roof_endless: 0
# ...
```

Refer <https://plantsvszombies.fandom.com/wiki/User_file_format>.

## Related Projects

- [plants-vs-zombies-user-file-editor](https://github.com/chiaracoetzee/plants-vs-zombies-user-file-editor):
  written in C#
