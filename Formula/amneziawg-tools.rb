class AmneziawgTools < Formula
  desc "Tools for the AmneziaWG"
  homepage "https://github.com/amnezia-vpn/amneziawg-tools"
  license "MIT"
  url "https://github.com/amnezia-vpn/amneziawg-tools.git",
       tag: "v1.0.20241018",
       revision: "c0b400c6dfc046f5cae8f3051b14cb61686fcf55"

  depends_on "bash"
  depends_on "amneziawg-go"

  def install
    if HOMEBREW_PREFIX.to_s != HOMEBREW_DEFAULT_PREFIX
      inreplace ["src/completion/wg-quick.bash-completion", "src/wg-quick/darwin.bash"],
                " /usr/local/etc/amnezia/amneziawg", "\\0 #{etc}/amnezia/amneziawg"
    end

    system "make", "-C", "src",
                         "BASHCOMPDIR=#{bash_completion}",
                         "WITH_WGQUICK=yes",
                         "WITH_SYSTEMDUNITS=no",
                         "PREFIX=#{prefix}",
                         "SYSCONFDIR=#{etc}",
                         "install"
  end

  test do
    system bin/"awg", "help"
  end
end
