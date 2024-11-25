class Shadowplay < Formula
  desc "Utility for checking puppet syntax, a puppet manifest linter, a pretty printer, and a utility for exploring the Hiera."
  homepage "https://github.com/mailru/shadowplay"
  license any_of: ["Apache-2.0", "MIT"]  
  url "https://github.com/mailru/shadowplay.git",
       tag: "v0.17.1",
       revision: "91aa44b496793850dc107f93a299a5347c466043"

  patch do
    url "https://raw.githubusercontent.com/dima424658/homebrew-clang/main/Patches/shadowplay/0001-update-target-compiler.patch"
    sha256 "1dffe455a9e60f9ab3f8f7771d8674b152776a90b1a4e4ee0cf3deb0875aab2d"
  end

  patch do
    url "https://raw.githubusercontent.com/dima424658/homebrew-clang/main/Patches/shadowplay/0002-fix-version.patch"
    sha256 "6a115ee29f3d21ae14169800a21e4c5f8439b936c1a5ae5b8c37e0f4a2007705"
  end

  depends_on "rust" => :build
  depends_on :macos

  def install
      system "cargo", "install", *std_cargo_args
  end

  test do
    assert_equal shell_output("#{bin}/shadowplay_macos --version"),
        "shadowplay 0.17.1"
  end
end
