class Arcanist < Formula
  desc "Command-line interface for Phabricator"
  homepage "https://github.com/phacility/arcanist"

  url "https://github.com/phacility/arcanist/archive/2565cc7b4d1dbce6bc7a5b3c4e72ae94be4712fe.tar.gz"
  sha256 "cd08d25cf4e14cbdab56705bf9cfe68fabda7ae95ced309e7eb14cdfdf2eceac"
  version "2020.27"

  head "https://github.com/phacility/arcanist.git"

  uses_from_macos "php"

  def install
    (libexec/"arcanist").install Dir["*"]
    bin.write_exec_script libexec/"arcanist/bin/arc"
    bin.write_exec_script libexec/"arcanist/bin/phage"

    bash_completion.install_symlink libexec/"arcanist/resources/shell/bash-completion" => "arc"
    zsh_completion.install_symlink libexec/"arcanist/resources/shell/bash-completion" => "_arc"
  end

  test do
    system "git", "init"
    (testpath/".arcconfig").write <<~EOS
      {"editor": "vim"}
    EOS
    assert_match "vim", shell_output("#{bin}/arc get-config editor")
  end
end
