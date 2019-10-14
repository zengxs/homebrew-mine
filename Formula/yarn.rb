class Yarn < Formula
  desc "JavaScript package manager"
  homepage "https://yarnpkg.com/"
  url "https://yarnpkg.com/downloads/1.19.1/yarn-v1.19.1.tar.gz"
  sha256 "34293da6266f2aae9690d59c2d764056053ff7eebc56b80b8df05010c3da9343"

  bottle :unneeded

  depends_on "node" => :recommended

  conflicts_with "hadoop", :because => "both install `yarn` binaries"

  def install
    (libexec/"yarnpkg").install Dir["*"]
    inreplace libexec/"yarnpkg/package.json", '"installationMethod": "tar"', '"installationMethod": "homebrew"'

    ["yarn", "yarnpkg"].each do |cmd|
      (bin/cmd).write_env_script libexec/"yarnpkg/bin/yarn.js", :PREFIX => HOMEBREW_PREFIX, :NPM_CONFIG_PYTHON => "/usr/bin/python"
    end
  end

  test do
    (testpath/"package.json").write('{"name": "test"}')
    system bin/"yarn", "add", "jquery"
    system bin/"yarn", "add", "fsevents", "--build-from-source=true"
  end
end
