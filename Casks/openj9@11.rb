cask 'openj9@11' do
  version '0.15.1,11.0.4+11'
  sha256 '7c09678d9c2d9dd0366693c6ab27bed39c76a23e7ac69b8a25c794e99dcf3ba7'

  # github.com/AdoptOpenJDK was verified as official when first introduced to the cask
  url "https://github.com/AdoptOpenJDK/openjdk11-binaries/releases/download/jdk-#{version.after_comma}_openj9-#{version.before_comma}/OpenJDK11U-jdk_x64_mac_openj9_#{version.after_comma.sub('+', '_')}_openj9-#{version.before_comma}.tar.gz"
  name 'AdoptOpenJDK Prebuilt Eclipse OpenJ9 JDK 11'
  homepage 'https://www.eclipse.org/openj9/'

  postflight do
    FileUtils.mv(staged_path.join("jdk-#{version.after_comma}/Contents/Home").children, staged_path)
    FileUtils.rm_rf(staged_path.join("jdk-#{version.after_comma}"))
  end

  caveats <<~EOS
    To make this as default jdk, you may need to set JAVA_HOME:
      export JAVA_HOME="#{staged_path}"
  EOS
end
