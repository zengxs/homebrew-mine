class Rls < Formula
  desc "Rust language server"
  homepage "https://github.com/rust-lang/rls"

  # https://static.rust-lang.org/dist/channel-rust-stable.toml
  url "https://mirrors.tuna.tsinghua.edu.cn/rustup/dist/2019-07-04/rls-1.36.0-x86_64-apple-darwin.tar.xz"
  mirror "https://static.rust-lang.org/dist/2019-07-04/rls-1.36.0-x86_64-apple-darwin.tar.xz"

  version "1.36.0,2019-07-04"
  sha256 "6e80d564f38c6bdd09added1c96dcd053867ce286122f17283e15e9be8174a5b"

  depends_on "rust"

  resource "rust-analysis" do
    url "https://mirrors.tuna.tsinghua.edu.cn/rustup/dist/2019-07-04/rust-analysis-1.36.0-x86_64-apple-darwin.tar.xz"
    mirror "https://static.rust-lang.org/dist/2019-07-04/rust-analysis-1.36.0-x86_64-apple-darwin.tar.xz"
    sha256 "ac812eb54118567ab99415551a934ff239c9f7c50d4ca6fa3d500a52282e71cb"
  end

  def install
    prefix.install Dir[buildpath/"rls-preview/*"]
    resource("rust-analysis").stage do
      lib.install Dir["#{Dir.pwd}/rust-analysis-x86_64-apple-darwin/lib/*"]
    end
  end

  test do
    system false
  end
end
