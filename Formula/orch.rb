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
  version "0.1.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/futuredapp/orch/releases/download/v0.1.2/orch-darwin-arm64"
      sha256 "b3391d0d9cd7f12883ce0d098f8e6562d1cdcc7b5afca16c6d1128afd76f0270"
    end
    on_intel do
      url "https://github.com/futuredapp/orch/releases/download/v0.1.2/orch-darwin-x64"
      sha256 "f6ee56118dc52a714b46ebc8f14e18e9aac799c5c5f859c4866f4809a78f1e94"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/futuredapp/orch/releases/download/v0.1.2/orch-linux-x64"
      sha256 "98c35e22f98cdc08f0a326a2c4968ca96d8fd9c485d5ad894281aa0fc5a4e970"
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
