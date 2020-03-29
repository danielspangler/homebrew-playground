class AdrJ < Formula
  desc "Installs the adoble adr-j fork of the adr-tools project."
  homepage "https://github.com/adoble/adr-j"
  url "https://github.com/adoble/adr-j/archive/v3.1.tar.gz"
  sha256 "77ccc5ccde7b783ac007e9c8bb1448423a4181c6ceba5ca1b04248cacba64427"

  depends_on "gradle" => :build
  depends_on "openjdk"

  def install

    system "gradle", "releaseJar"

    lib.install "./build/releases/adr-j.jar"
    (buildpath/"build/releases/adr").write <<~EOS
      #!/bin/bash
      java -jar #{lib}/adr-j.jar  "$@"
    EOS
    bin.install "build/releases/adr"
  end

  test do
    system bin/"adr"
  end
end
