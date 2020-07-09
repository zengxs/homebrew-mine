class Gost < Formula
  desc "Simple tunnel written in golang"
  homepage "https://github.com/ginuerzh/gost"
  url "https://github.com/ginuerzh/gost/releases/download/v2.11.0/gost-darwin-amd64-2.11.0.gz"
  sha256 "a19da66f441f184319b243ae6254e877b8ab34482508817f85929a08d1f6ddc7"

  def install
    bin.install "gost-darwin-amd64" => "gost"
    (etc/"gost.json").write <<~EOS
      {
        "ServeNodes": [
          "http://localhost:8888"
        ],
        "ChainNodes": [
        ]
      }
    EOS
  end

  plist_options :manual => "#{HOMEBREW_PREFIX}/opt/gost/bin/gost -C #{HOMEBREW_PREFIX}/etc/gost.json"

  def plist
    <<~EOS
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
        <dict>
          <key>Label</key>
          <string>#{plist_name}</string>
          <key>ProgramArguments</key>
          <array>
            <string>#{opt_bin}/gost</string>
            <string>-C</string>
            <string>#{etc}/gost.json</string>
          </array>
          <key>RunAtLoad</key>
          <true/>
          <key>KeepAlive</key>
          <true/>
        </dict>
      </plist>
    EOS
  end

  test do
    proxy = fork { exec bin/"gost", "-L=http://127.0.0.1:8888" }
    sleep 3
    begin
      system "curl", "-x", "http://127.0.0.1:8888", "https://www.baidu.com"
    ensure
      Process.kill 9, proxy
    end
  end
end
