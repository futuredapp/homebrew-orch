# Homebrew formula for orch — the code-first coding-agent orchestrator.
#
# This is a FORMULA, not a cask: the per-platform binaries are unsigned, but a
# tap formula does not receive the `com.apple.quarantine` attribute, so it
# installs and runs clean on macOS with no Apple Developer certificate.
#
# The url/sha256/version fields below are rewritten by scripts/bump-formula.ts
# in the orch repo (run by the release workflow's bump-formula job). The seed
# values (version 0.0.0, all-zero sha256) are deliberate placeholders — they are
# filled by the cold-start bump, never edited by hand. The block layout (one
# nested on_arm/on_intel block per platform, each with its own url + sha256
# keyed by the orch-<os>-<arch> asset name in the url) is the contract that
# bump-formula's anchored replacements depend on; keep it in sync with that
# script.
class Orch < Formula
  desc "Code-first orchestrator for chaining coding-agent CLIs (Claude Code, Codex)"
  homepage "https://github.com/futuredapp/orch"
  version "1.2.3"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/futuredapp/orch/releases/download/v1.2.3/orch-darwin-arm64"
      sha256 "18729305d3ef94a9207c22076b4f2ddd67ef87a956822ef9c8008446373ad63a"
    end
    on_intel do
      url "https://github.com/futuredapp/orch/releases/download/v1.2.3/orch-darwin-x64"
      sha256 "c9dcfa31891d08583d4bfb8410d70a60e362ed97542508379df2a0c46d143a42"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/futuredapp/orch/releases/download/v1.2.3/orch-linux-x64"
      sha256 "9dcd191b00bfd2a5edd1d7a4c0a2a142ed6f908701fb4f8531a28234fbb12703"
    end
  end

  def install
    # Binaries ship raw (not tarballs); the downloaded file is named after its
    # asset (orch-<os>-<arch>). Install whichever one was fetched as `orch`.
    bin.install Dir["orch-*"].first => "orch"
  end

  test do
    assert_match "orch", shell_output("#{bin}/orch --help")
  end
end
