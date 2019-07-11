class Rust < Formula
  desc "Safe, concurrent, practical language"
  homepage "https://www.rust-lang.org/"
  url "https://mirrors.tuna.tsinghua.edu.cn/rustup/dist/2019-07-04/rust-1.36.0-x86_64-apple-darwin.tar.xz"
  mirror "https://static.rust-lang.org/dist/2019-07-04/rust-1.36.0-x86_64-apple-darwin.tar.xz"
  sha256 "3507ccf18600dc79d69e5f3d6ac0454d4849c41922db107a1bcb7b4fefa2fd55"

  conflicts_with "rust"

  resource "rust-src" do
    url "https://mirrors.tuna.tsinghua.edu.cn/rustup/dist/2019-07-04/rust-src-1.36.0.tar.xz"
    mirror "https://static.rust-lang.org/dist/2019-07-04/rust-src-1.36.0.tar.xz"
    sha256 "0fbf059a6875cb8d207df5d94b36c76ca74dfb05506fc5ab28e7641eb4b78be7"
  end

  def install
    share_doc = share/"doc"
    ruslib = lib/"rustlib"
    rustlib_arch = ruslib/"x86_64-apple-darwin"
    rustlib_bin = rustlib_arch/"bin"
    rustlib_lib = rustlib_arch/"lib"

    rustlib_arch_path = "lib/rustlib/x86_64-apple-darwin"

    (buildpath/"rustc").cd do
      bin.install Dir["bin/*"]
      lib.install Dir["lib/*"]
      share.install Dir["share/*"]
    end

    (buildpath/"cargo").cd do
      bin.install Dir["bin/*"]
      bash_completion.install Dir["etc/bash_completion.d/*"]
      zsh_completion.install Dir["share/zsh/site-functions/*"]
      share_doc.install Dir["share/doc/*"]
      man1.install Dir["share/man/man1/*"]
    end

    (buildpath/"clippy-preview").cd do
      bin.install Dir["bin/*"]
      share_doc.install Dir["share/doc/*"]
    end

    (buildpath/"lldb-preview").cd do
      rustlib_bin.install Dir["#{rustlib_arch_path}/bin/*"]
      rustlib_lib.install Dir["#{rustlib_arch_path}/lib/*"]
    end

    (buildpath/"llvm-tools-preview").cd do
      rustlib_bin.install Dir["#{rustlib_arch_path}/bin/*"]
    end

    (buildpath/"miri-preview").cd do
      bin.install Dir["bin/*"]
      share_doc.install Dir["share/doc/*"]
    end

    (buildpath/"rls-preview").cd do
      bin.install Dir["bin/*"]
      share_doc.install Dir["share/doc/*"]
    end

    (buildpath/"rust-analysis-x86_64-apple-darwin").cd do
      rustlib_arch.install Dir["#{rustlib_arch_path}/*"]
    end

    (buildpath/"rust-docs").cd do
      share_doc.install Dir["share/doc/*"]
    end

    (buildpath/"rust-std-x86_64-apple-darwin").cd do
      rustlib_lib.install Dir["#{rustlib_arch_path}/lib/*"]
    end

    (buildpath/"rustfmt-preview").cd do
      bin.install Dir["bin/*"]
      share_doc.install Dir["share/doc/*"]
    end

    resource("rust-src").stage do
      ruslib.install Dir["rust-src/lib/rustlib/*"]
    end
  end

  def post_install
    Dir["#{lib}/**/*.dylib"].each do |dylib|
      chmod 0664, dylib
      MachO::Tools.change_dylib_id(dylib, "@rpath/#{File.basename(dylib)}")
      chmod 0444, dylib
    end
  end

  test do
    system false
  end
end
