cask "ms-edge" do
  version "87.0.664.66"
  sha256 "4069c52138ba7fcb6787fba2efc2c991b37b1b5d351aba413a0dff3f299aeff7"

  url "https://files.zengxs.com/Dist/microsoft-edge/microsoft-edge-#{version}.tgz?raw=0",
      verified: "files.zengxs.com/"
  appcast "https://macupdater.net/cgi-bin/check_urls/check_url_redirect.cgi?url=https://go.microsoft.com/fwlink/?linkid=2069148"
  name "Microsoft Edge"
  desc "Multi-platform web browser"
  homepage "https://www.microsoft.com/edge"

  app "Microsoft Edge.app"

  uninstall pkgutil: "com.microsoft.edgemac"

  zap trash: [
    "~/Library/Application Support/Microsoft Edge",
    "~/Library/Caches/Microsoft Edge",
    "~/Library/Preferences/com.microsoft.edgemac.plist",
    "~/Library/Saved Application State/com.microsoft.edgemac.savedState",
  ],
      rmdir: "/Library/Application Support/Microsoft"
end
