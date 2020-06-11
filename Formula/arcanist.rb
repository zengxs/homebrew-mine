class Arcanist < Formula
  desc "Command-line interface for Phabricator"
  homepage "https://github.com/phacility/arcanist"

  url "https://github.com/phacility/arcanist/archive/d1c07b4d2634685e19f88a5acb0971a3440821f0.tar.gz"
  sha256 "c9ffb6d9fd497cca3ec9c2ee1ee47b9c51b6c81d19c0f8f73001e66bc6b128c9"
  version "2020.17"

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
