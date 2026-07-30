cask "spectroscope" do
  version "0.4.1"
  sha256 "c0cd94752ac73cdcab0ef5964ec31e130f1154506ccf7d229b1f6fbaa4d1d70e"

  url "https://github.com/spectroscope/spectroscope/releases/download/v#{version}/spectroscope-#{version}-arm64.dmg"
  name "spectroscope"
  desc "Agent orchestrator with a live cockpit, bundled JRE and local model runtime"
  homepage "https://spectroscope.ai/"

  livecheck do
    url "https://github.com/spectroscope/spectroscope"
    strategy :github_latest
  end

  # The run kit bundles a jlink'd JRE and llama.cpp's llama-server for
  # Apple silicon only; there is no Intel build to fall back to.
  depends_on arch: :arm64

  app "spectroscope.app"

  # Deliberately NOT zapped: ~/.spectro — that is the session store and
  # settings shared with the CLI and server-jar installs of the same
  # product; uninstalling the desktop shell must not delete recorded work.
  zap trash: [
    "~/Library/Application Support/spectro-desktop",
    "~/Library/Caches/spectro-desktop",
    "~/Library/Saved Application State/dev.spectroscope.desktop.savedState",
  ]
end
