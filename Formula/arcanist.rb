class Arcanist < Formula
  desc "Command-line interface for Phabricator"
  homepage "https://github.com/phacility/arcanist"

  stable do
    url "https://github.com/phacility/arcanist.git",
      :revision => "8b5fbb5a134611dd1e254bffee0166090caf5ac2"
    version "2019.09.09"

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
