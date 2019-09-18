class OracleInstantclientBasic < Formula
  desc "Oracle Instant Client Basic"
  homepage "https://www.oracle.com/database/technologies/instant-client/macos-intel-x86-downloads.html"
  url "https://download.oracle.com/otn_software/mac/instantclient/193000/instantclient-basic-macos.x64-19.3.0.0.0dbru.zip"
  version "19.3.0.0.0"
  sha256 "f4335c1d53e8188a3a8cdfb97494ff87c4d0f481309284cf086dc64080a60abd"

  def install
    (libexec/"oracle/instantclient").install Dir["*"]
    lib.install_symlink Dir[libexec/"oracle/instantclient/*.dylib*"]
  end

  test do
    system "false"
  end
end
