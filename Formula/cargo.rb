class Cargo < Formula
  desc "Rust package manager"
  homepage "https://github.com/rust-lang/cargo"

  # https://static.rust-lang.org/dist/channel-rust-stable.toml
  url "https://mirrors.tuna.tsinghua.edu.cn/rustup/dist/2019-07-04/cargo-0.37.0-x86_64-apple-darwin.tar.xz"
  mirror "https://static.rust-lang.org/dist/2019-07-04/cargo-0.37.0-x86_64-apple-darwin.tar.xz"

  version "0.37.0,2019-07-04"
  sha256 "fadc3c67d0f52bc2df2e68ac6ece175951550b0ffe825b37a9473352f3622f25"

  conflicts_with "rust"

  def install
    prefix.install Dir[buildpath/"cargo/*"]
  end

  test do
    system bin/"cargo", "new", "--bin", "homebrew"
    assert_predicate testpath/"homebrew/Cargo.toml", :exist?
  end
end
