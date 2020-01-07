class RustSuite < Formula
  desc "Official rust-lang development suite (stable)"
  homepage "https://www.rust-lang.org/"

  # Channel: https://mirrors.tuna.tsinghua.edu.cn/rustup/dist/channel-rust-stable.toml
  url "https://mirrors.tuna.tsinghua.edu.cn/rustup/dist/2019-12-19/rust-1.40.0-x86_64-apple-darwin.tar.xz"
  mirror "https://static.rust-lang.org/dist/rust-1.40.0-x86_64-apple-darwin.tar.xz"
  sha256 "14f047b4fbd3a7db1cba49c86a066650703a354db360fefec0e35e8dc63a3dea"

  conflicts_with "rust"

  uses_from_macos "bash" => :build

  resource "rust-src" do
    url "https://mirrors.tuna.tsinghua.edu.cn/rustup/dist/2019-12-19/rust-src-1.40.0.tar.xz"
    mirror "https://static.rust-lang.org/dist/rust-src-1.40.0.tar.xz"
    sha256 "48466c3aa59b09bfa5d251f6443fc4a6136934869024e17c806c9bb853b2b28a"
  end

  def install
    system "bash", "install.sh", "--prefix=#{prefix}"
    resource("rust-src").stage do
      system "bash", "install.sh", "--prefix=#{prefix}"
    end
  end

  def caveats
    <<~EOS
      Components in rust-suite:
        * rustc
        * cargo
        * rls-preview
        * clippy-preview
        * miri-preview
        * rustfmt-preview
        * llvm-tools-preview
        * rust-analysis-x86_64-apple-darwin
        * rust-std-x86_64-apple-darwin
        * rust-docs
        * rust-src
    EOS
  end

  test do
    system "#{bin}/rustdoc", "-h"
    (testpath/"hello.rs").write <<~EOS
      fn main() {
        println!("Hello World!");
      }
    EOS
    system "#{bin}/rustc", "hello.rs"
    assert_equal "Hello World!\n", `./hello`
    system "#{bin}/cargo", "new", "hello_world", "--bin"
    assert_equal "Hello, world!",
                 (testpath/"hello_world").cd { `#{bin}/cargo run`.split("\n").last }
  end
end
