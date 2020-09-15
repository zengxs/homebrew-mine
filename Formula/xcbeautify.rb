class Xcbeautify < Formula
  desc "Little beautifier tool for xcodebuild"
  homepage "https://github.com/thii/xcbeautify"
  url "https://github.com/thii/xcbeautify/releases/download/0.8.1/xcbeautify-0.8.1-x86_64-apple-macosx.zip"
  sha256 "75e9d345a68a759ab268f0ecef4373a0ae590b07939096a076bdb25f20e69143"

  bottle :unneeded

  def install
    bin.install "xcbeautify"
  end

  test do
    system bin/"xcbeautify", "--version"
  end
end
