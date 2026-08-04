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

## If this cask is not for you

The cask declares `depends_on arch: :arm64`, because the run kit bundles a
JRE and a local model runtime built for Apple silicon and there is no Intel
build to fall back to. `brew install` refuses on anything else rather than
installing something that cannot start. The other doors into the same
release:

| you are on | take |
|---|---|
| macOS, Apple silicon, no Homebrew | the notarized `spectroscope-<version>-arm64.dmg` from the [release page](https://github.com/spectroscope/spectroscope/releases/latest) |
| Debian 12 or Ubuntu 24.04, x86_64 | the apt repository at [apt.spectroscope.dev](https://apt.spectroscope.dev), signed indexes against one pinned key |
| any other x86_64 Linux | `spectroscope-<version>-x86_64.AppImage` from the release page |
| everything else, arm64 Linux included | the CLI zip or the server jar; both need a JDK 21 and run anywhere |

There is no arm64 Linux package and no Windows package: the desktop shell
ships for macOS on Apple silicon and for x86_64 Linux, nowhere else.

## Releasing (maintainer note)

After a GitHub release is published (playbook step 8), bump the cask:

```bash
scripts/bump-cask.sh 0.5.0
```

The script reads the new DMG's sha256 straight from the GitHub release
asset digest, rewrites `Casks/spectroscope.rb`, and leaves the commit to
you. `brew audit --cask spectroscope/tap/spectroscope` before pushing.
