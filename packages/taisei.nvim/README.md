# taisei.nvim

A taisei progress file editor based on neovim.

## Usage

```sh
zstd -d ~/.local/share/taisei/progress.zst
vi taisei://
```

```yaml
unlock_bgms: 4294967295  # 0xFFFFFFFF
unlock_cutscenes: 4294967295
```

```vim
:wq
```

```sh
zstd ~/.local/share/taisei/progress
```

All BGMs and cutscenes will be unlocked.
