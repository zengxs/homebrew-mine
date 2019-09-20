class OracleInstantclientSqlplus < Formula
  desc "Command-line tool for SQL and PL/SQL queries"
  homepage "https://www.oracle.com/database/technologies/instant-client/macos-intel-x86-downloads.html"
  url "https://download.oracle.com/otn_software/mac/instantclient/193000/instantclient-sqlplus-macos.x64-19.3.0.0.0dbru.zip"
  version "19.3.0.0.0"
  sha256 "f7565c3cbf898b0a7953fbb0017c5edd9d11d1863781588b7caf3a69937a2e9e"

  depends_on "oracle-instantclient-basic"

  def install
    (libexec/"oracle/instantclient").install Dir["*"]
    lib.install_symlink Dir["#{libexec}/oracle/instantclient/*.dylib*"]
    bin.install_symlink libexec/"oracle/instantclient/sqlplus"
  end

  test do
    system "false"
  end
end
