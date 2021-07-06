class FfmpegStatic < Formula
  desc "Play, record, convert, and stream audio and video (x86_64)"
  homepage "https://ffmpeg.org/"
  url "https://evermeet.cx/ffmpeg/ffmpeg-4.4.zip"
  sha256 "ee7fa287e35bb964fd7a1dfacc388b96cf376f090d4cbbb9d75d707e313b9e98"

  resource "ffprobe" do
    url "https://evermeet.cx/ffmpeg/ffprobe-4.4.zip"
    sha256 "f574171f90686747ef12504fb4f8629ce3f9493c13727f928d594d7ac0d66169"
  end

  resource "ffplay" do
    url "https://evermeet.cx/ffmpeg/ffplay-4.4.zip"
    sha256 "ccc90fcfd90d3be527f0a1a589b1802cfaebf7d112a407e2a6f14856b05d4878"
  end

  resource "ffserver" do
    url "https://evermeet.cx/ffmpeg/ffserver-3.4.2.zip"
    sha256 "52f2e7045a84dfd34af08319459cdfd17e682b9909cfe9f2178414c1cbc02a12"
  end

  conflicts_with "ffmpeg", :because => "both install `ffmpeg` binaries"

  def install
    bin.install "ffmpeg"

    ["ffprobe", "ffplay", "ffserver"].each do |rsrc|
      resource(rsrc).stage do
        bin.install rsrc
      end
    end
  end

  test do
    # Create an example mp4 file
    mp4out = testpath/"video.mp4"
    system bin/"ffmpeg", "-filter_complex", "testsrc=rate=1:duration=1", mp4out
    assert_predicate mp4out, :exist?
  end
end
