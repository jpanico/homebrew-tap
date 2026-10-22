# jpanico/tap

Homebrew formulae for tools by Joe Panico.

| Formula | What it is |
|---|---|
| [`reveal`](Formula/reveal.rb) | [Reveal](https://github.com/jpanico/reveal), a handler for `reveal:` links, which select a file in Finder |

## Reveal

```bash
brew install jpanico/tap/reveal
brew services start jpanico/tap/reveal
```

Give the full name, `jpanico/tap/reveal`: a plain `reveal` is an unrelated
cask. The formula builds Reveal from source, which needs the Xcode Command
Line Tools and macOS 14 or later. See Reveal's README for how to use it.

## Releasing a new version of Reveal

1. Tag the release in the reveal repo and push the tag:
   `git tag -a v1.1.0 -m "Reveal 1.1.0" && git push origin v1.1.0`.
2. In `Formula/reveal.rb`, change the version in `url`, and set `sha256` to
   the new tarball's checksum:
   `curl -sL https://github.com/jpanico/reveal/archive/refs/tags/v1.1.0.tar.gz | shasum -a 256`.
3. Commit and push this repo. `brew upgrade jpanico/tap/reveal` then installs
   it; run `brew services restart jpanico/tap/reveal` afterwards.
