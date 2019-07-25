class MicrosoftDistOpenjdk < Formula
  desc "Microsoft's Mobile OpenJDK Distribution"
  homepage "https://docs.microsoft.com/en-us/xamarin/android/get-started/installation/openjdk"
  url "https://dl.xamarin.com/OpenJDK/mac/microsoft-dist-openjdk-1.8.0.9.zip"
  sha256 "6a0f1b63d2bb71d3419bfe174340d1ac409d986378a34eb52dae78c77c17a710"

  keg_only :provided_by_macos

  def install
    prefix.install Dir["*"]
    # FIXME: Failed to fix install linkage 
  end

  test do
    ENV["LC_ALL"] = "en_US.UTF-8"

    (testpath/"Hello.java").write <<~EOS
      public class Hello {
        public static void main(String[] args) {
          System.out.println("Hello World");
        }
      }
    EOS
    system bin/"javac", "Hello.java"
    assert_predicate testpath/"Hello.class", :exist?
    assert_equal "Hello World\n", shell_output("#{bin}/java Hello") 
  end
end
