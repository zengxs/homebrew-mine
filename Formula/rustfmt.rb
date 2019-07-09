class Rustfmt < Formula
  desc "Rust code formatter"
  homepage "https://github.com/rust-lang/rustfmt"

  # https://static.rust-lang.org/dist/channel-rust-stable.toml
  url "https://mirrors.tuna.tsinghua.edu.cn/rustup/dist/2019-07-04/rustfmt-1.2.2-x86_64-apple-darwin.tar.xz"
  mirror "https://static.rust-lang.org/dist/2019-07-04/rustfmt-1.2.2-x86_64-apple-darwin.tar.xz"

  version "1.2.2,2019-07-04"
  sha256 "9cce97f9b218684b0bfa57c361272271264010aa4cc93b5581390b002e2028be"

  depends_on "rust"

  def install
    prefix.install Dir[buildpath/"rustfmt-preview/*"]
  end

  test do
    (testpath/"Cargo.toml").write <<~EOS
      [package]
      name = "hello"
      version = "1.0.0"
      authors = ["zengxs"]
    EOS
    (testpath/"src/main.rs").write <<~EOS
      println!  ( "hello, world" )  ;
    EOS

    system "cargo", "fmt"
    assert_match 'println!("hello, world");', (testpath/"src/main.rs").read
  end
end
