# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class DieselCli < Formula
  desc "Command-line tool for Rust ORM Diesel with Barrel"
  homepage "https://diesel.rs"
  url "https://assets-1251845220.cos.ap-guangzhou.myqcloud.com/assets/diesel_cli-1.4.5-darwin.tar.gz"
  sha256 "48e321214bbeade54c5450afc6f733198fb48e00f11d5a3c579f0eaf77397fd2"

  bottle :unneeded

  conflicts_with "diesel", :because => "both install `diesel` binaries"

  def install
    prefix.install Dir["*"]
  end

  test do
    system "false"
  end
end
