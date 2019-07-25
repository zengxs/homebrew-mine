cask 'microsoft-openjdk' do
  version '1.8.0.9'
  sha256 '6a0f1b63d2bb71d3419bfe174340d1ac409d986378a34eb52dae78c77c17a710'

  # dl.xamarin.com was verified as official when first introduced to the cask
  url "https://dl.xamarin.com/OpenJDK/mac/microsoft-dist-openjdk-#{version}.zip"
  name "Microsoft's Mobile OpenJDK Distribution"
  homepage 'https://docs.microsoft.com/en-us/xamarin/android/get-started/installation/openjdk'

  caveats <<~EOS
    To make this as default jdk, you may need to set JAVA_HOME:
      export JAVA_HOME="#{staged_path}"
  EOS
end
