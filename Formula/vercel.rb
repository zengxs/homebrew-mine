class Vercel < Formula
  desc "Command-line interface enables instant cloud deployment and local development"
  homepage "https://vercel.com/download"
  url "https://files.zengxs.com/Dist/vercel/vercel-21.0.1-dist.tar.xz?raw=1"
  sha256 "c25e138aab8f8783f1b1d9cd83fbe4a865b7a55fe6b37b58fb63c7324c91fb03"

  depends_on "node"

  def install
    libexec.install Dir["*"]
    ["vc", "vercel"].each do |bin_name|
      binary = bin/bin_name
      binary.write_env_script libexec/"vercel/dist/index.js", :NODE_PATH => libexec
    end
  end

  test do
    system "false"
  end
end
