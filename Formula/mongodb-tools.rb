class MongodbTools < Formula
  desc "Collection of command-line utilities for working with a MongoDB deployment"
  homepage "https://www.mongodb.com/try/download/database-tools"
  url "https://files.zengxs.com/Dist/mongodb/mongodb-database-tools-macos-x86_64-100.2.1.zip?raw=1"
  mirror "https://fastdl.mongodb.org/tools/db/mongodb-database-tools-macos-x86_64-100.2.1.zip"
  sha256 "83c0db538eee814ef40943e2df6ca3002838f9731072dd7833fd44abc73a98f3"
  license "AGPL-3.0"

  bottle :unneeded

  def install
    prefix.install Dir["*"]
  end

  test do
    system "false"
  end
end
