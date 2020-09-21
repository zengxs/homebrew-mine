class Arcanist < Formula
  desc "Command-line interface for Phabricator"
  homepage "https://github.com/phacility/arcanist"

  url "https://github.com/phacility/arcanist/archive/68dba1a2c6d9fe1de7b9d4c944336458d0f016b3.tar.gz"
  sha256 "8804a17acff0a137df1095a5fda67263ec6a7e96056a6d6d418391bf88824968"
  version "2020.37"

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
