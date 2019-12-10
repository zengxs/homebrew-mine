class Poetry < Formula
  desc "Python package management tool"
  homepage "https://github.com/sdispater/poetry"
  url "https://github.com/sdispater/poetry/releases/download/1.0.0b9/poetry-1.0.0b9-darwin.tar.gz"
  sha256 "26b1ac56e5bba2011feaa36a47cb9d20b5af2c5b9b2060978314fad2cfdb7f97"

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
  end

  test do
    ENV["LC_ALL"] = "en_US.UTF-8"
    assert_match "Created package", shell_output("#{bin}/poetry new homebrew")
    cd testpath/"homebrew" do
      system bin/"poetry", "config", "settings.virtualenvs.in-project", "true"
      system bin/"poetry", "add", "bcrypt"
    end

    assert_predicate testpath/"homebrew/pyproject.toml", :exist?
    assert_predicate testpath/"homebrew/poetry.lock", :exist?
    assert_match "bcrypt", (testpath/"homebrew/pyproject.toml").read
  end
end
