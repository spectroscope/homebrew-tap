# spectroscope — Homebrew tap

The desktop run kit as a cask: signed, notarized, self-contained (bundled
JRE and local model runtime), Apple silicon.

```bash
brew install --cask spectroscope/tap/spectroscope
```

Or in two steps:

```bash
brew tap spectroscope/tap
brew install --cask spectroscope
```

Uninstall with `brew uninstall --cask spectroscope`. A full `--zap` also
removes the Electron shell's own state, but deliberately never touches
`~/.spectro` — that is your session store, shared with the CLI and the
server jar.

## Releasing (maintainer note)

After a GitHub release is published (playbook step 8), bump the cask:

```bash
scripts/bump-cask.sh 0.4.2
```

The script reads the new DMG's sha256 straight from the GitHub release
asset digest, rewrites `Casks/spectroscope.rb`, and leaves the commit to
you. `brew audit --cask spectroscope/tap/spectroscope` before pushing.
