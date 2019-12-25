class Arcanist < Formula
  desc "Command-line interface for Phabricator"
  homepage "https://github.com/phacility/arcanist"

  stable do
    url "https://github.com/phacility/arcanist.git",
      :revision => "bac2028421a4be6e34e08764bbbda49e68b3a604"
    version "2019.11.20"

    resource "libphutil" do
      url "https://github.com/phacility/libphutil.git", :branch => "stable"
    end
  end

  head do
    url "https://github.com/phacility/arcanist.git"

    resource "libphutil" do
      url "https://github.com/phacility/libphutil.git"
    end
  end

  def install
    resource("libphutil").stage do
      (libexec/"libphutil").install Dir["*"]
    end

    (libexec/"arcanist").install Dir["*"]
    bin.write_exec_script libexec/"arcanist/bin/arc"

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
