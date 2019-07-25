class Json2csv < Formula
  desc "Command-line tool to convert json to csv"
  homepage "https://github.com/jehiah/json2csv"
  url "https://github.com/jehiah/json2csv/releases/download/v.1.2.0/json2csv-1.2.0.darwin-amd64.go1.8.tar.gz"
  version "1.2.0"
  sha256 "f0f97a04cce7cf81996f783b0a028fe5579302fb34c685aa6adcc9ece43ec2f8"

  def install
    bin.install "json2csv"
  end

  test do
    (testpath/"test.json").write <<~EOS
      {"hello":"world"}
    EOS
    system bin/"json2csv", "-i", "test.json", "-p", "-k", "hello", "-o", testpath/"test.csv"
    assert_predicate testpath/"test.csv", :exist?
    assert_match "hello\nworld", (testpath/"test.csv").read
  end
end
