class Xcbeautify < Formula
  desc "Little beautifier tool for xcodebuild"
  homepage "https://github.com/thii/xcbeautify"
  url "https://github.com/thii/xcbeautify/releases/download/0.7.4/xcbeautify-0.7.4-x86_64-apple-macosx.zip"
  sha256 "ea1d194624b9309c92a310375d0b6fa679ff9ad5a4780db4e83907bf459e973e"

  bottle :unneeded

  def install
    bin.install "xcbeautify"
  end

  test do
    system bin/"xcbeautify", "--version"
  end
end
