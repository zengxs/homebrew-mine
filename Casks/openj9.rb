cask 'openj9' do
  version '0.20.0,8u252-b09.2'
  sha256 'f522061a23290bce3423e49025a95b6e78d6f30e2741817e83c8fdba4c0c4ae7'

  # github.com/AdoptOpenJDK was verified as official when first introduced to the cask
  url "https://github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk#{version.after_comma}_openj9-#{version.before_comma}/OpenJDK8U-jdk_x64_mac_openj9_#{version.after_comma.major.no_hyphens}_openj9-#{version.before_comma}.tar.gz"
  name 'AdoptOpenJDK Prebuilt Eclipse OpenJ9'
  homepage 'https://www.eclipse.org/openj9/'

  postflight do
    FileUtils.mv(staged_path.join("jdk#{version.after_comma.major}/Contents/Home").children, staged_path)
    FileUtils.rm_rf(staged_path.join("jdk#{version.after_comma.major}"))
  end

  caveats <<~EOS
    To make this as default jdk, you may need to set JAVA_HOME:
      export JAVA_HOME="#{staged_path}"
  EOS
end
