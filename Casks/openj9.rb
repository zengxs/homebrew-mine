cask 'openj9' do
  version '0.15.1,8u222-b10'
  sha256 'df185e167756332163633a826b329db067f8a721f7d5d27f0b353a35fc415de0'

  # github.com/AdoptOpenJDK was verified as official when first introduced to the cask
  url "https://github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk#{version.after_comma}_openj9-#{version.before_comma}/OpenJDK8U-jdk_x64_mac_openj9_#{version.after_comma.no_hyphens}_openj9-#{version.before_comma}.tar.gz"
  name 'AdoptOpenJDK Prebuilt Eclipse OpenJ9'
  homepage 'https://www.eclipse.org/openj9/'

  postflight do
    FileUtils.mv(staged_path.join("jdk#{version.after_comma}/Contents/Home").children, staged_path)
    FileUtils.rm_rf(staged_path.join("jdk#{version.after_comma}"))
  end

  caveats <<~EOS
    To make this as default jdk, you may need to set JAVA_HOME:
      export JAVA_HOME="#{staged_path}"
  EOS
end
