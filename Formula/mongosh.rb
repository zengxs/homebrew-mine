class Mongosh < Formula
  desc "Quickest way to connect, configure, query, and work with your MongoDB database"
  homepage "https://www.mongodb.com/try/download/shell"
  url "https://files.zengxs.com/Dist/mongodb/mongosh-0.5.2-darwin.zip?raw=1"
  mirror "https://downloads.mongodb.com/compass/mongosh-0.5.2-darwin.zip"
  sha256 "bfb0f652404d2004df40196a498fac0acaa3ca8d19f2f521eec0a8cb0cc03d03"
  license "AGPL-3.0"

  def install
    bin.install "mongosh"
  end

  test do
    system "false"
  end
end
