class Aria2 < Formula
  desc "Patched aria2 downloader (16 connections limit unlocked)"
  homepage "https://aria2.github.io/"
  url "https://github.com/aria2/aria2/releases/download/release-1.35.0/aria2-1.35.0.tar.xz"
  sha256 "1e2b7fd08d6af228856e51c07173cfcf987528f1ac97e04c5af4a47642617dfd"

  depends_on "pkg-config" => :build
  depends_on "libssh2"

  def install
    inreplace "configure", "-std=c++11", "-std=c++14"

    # Unlock 16 connections per server limit
    inreplace "src/OptionHandlerFactory.cc", "\"1\", 1, 16, 'x'", "\"1\", 1, -1, 'x'"

    args = %W[
      --disable-dependency-tracking
      --prefix=#{prefix}
      --with-appletls
      --with-libssh2
      --without-openssl
      --without-gnutls
      --without-libgmp
      --without-libnettle
      --without-libgcrypt
    ]

    system "./configure", *args
    system "make", "install"

    bash_completion.install "doc/bash_completion/aria2c"
  end

  test do
    system "#{bin}/aria2c", "https://brew.sh/"
    assert_predicate testpath/"index.html", :exist?, "Failed to create index.html!"
  end
end
