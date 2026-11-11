# ocean/homebrew-tap

Homebrew formulae by ocean.

## fm1probe

[fm1probe](https://github.com/ocean/FM1Kit) is a Mac command-line tool for M-VAVE FM-1
synthesisers and the firmware developers who work on them: it identifies a connected FM-1,
inspects, checks and compares firmware packages and flash backups, names the SysEx messages it
sends, runs a simulated FM-1 for testing updaters, and installs firmware.

```sh
brew install ocean/tap/fm1probe
fm1probe --version
```

It's built from source, so it needs Xcode 16.3 or later, and macOS 14 or later.
