class Arcanist < Formula
  desc "Command-line interface for Phabricator"
  homepage "https://github.com/phacility/arcanist"

  url "https://github.com/phacility/arcanist/archive/ccd39feb6d3bbd84e122817b0d8b36284b6edd9d.tar.gz"
  sha256 "d885b6df3d0ad7ccf2abb54d71364f465b7b774e1ffde0ea326c793ffe5a9cf2"
  version "2020.29"

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
