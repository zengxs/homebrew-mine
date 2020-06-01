class PythonPoetry < Formula
  desc "Python package management tool"
  homepage "https://python-poetry.org"
  url "https://github.com/python-poetry/poetry/releases/download/1.0.5/poetry-1.0.5-darwin.tar.gz"
  sha256 "57f1666b8abb23dd84fa16623337e6d97d209b7faf288a1b4c09e3ca82ca296b"

  resource "pysocks" do
    url "https://files.pythonhosted.org/packages/bd/11/293dd436aea955d45fc4e8a35b6ae7270f5b8e00b53cf6c024c83b657a11/PySocks-1.7.1.tar.gz"
    sha256 "3f8804571ebe159c380ac6de37643bb4685970655d3bba243530d6558b799aa0"
  end

  depends_on "python"

  def install
    ENV.prepend_create_path "PYTHONPATH", libexec/"vendor/python/site-packages"
    (libexec/"vendor/python/site-packages/poetry").install Dir["*"]

    (libexec/"bin/poetry").write <<~EOS
      #!/bin/sh
      python3 -m poetry "$@"
    EOS
    (libexec/"bin/poetry").chmod 0755
    (bin/"poetry").write_env_script(libexec/"bin/poetry", :PYTHONPATH => ENV["PYTHONPATH"])
    chmod 0755, bin/"poetry"

    [
      ["bash", bash_completion/"poetry"],
      ["fish", fish_completion/"poetry.fish"],
      ["zsh", zsh_completion/"_poetry"],
    ].each do |shell, completion|
      completion.write Utils.popen_read("#{bin}/poetry completions #{shell}")
    end

    resource("pysocks").stage do
      sitepkg_dir = libexec/"vendor/python/site-packages"
      sitepkg_dir.install "socks.py"
      sitepkg_dir.install "sockshandler.py"
    end
  end

  test do
    ENV["LC_ALL"] = "en_US.UTF-8"
    assert_match "Created package", shell_output("#{bin}/poetry new homebrew")
    cd testpath/"homebrew" do
      system bin/"poetry", "config", "virtualenvs.in-project", "true"
      system bin/"poetry", "add", "bcrypt"
    end

    assert_predicate testpath/"homebrew/pyproject.toml", :exist?
    assert_predicate testpath/"homebrew/poetry.lock", :exist?
    assert_match "bcrypt", (testpath/"homebrew/pyproject.toml").read
  end
end
