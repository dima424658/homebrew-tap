class AmneziawgGo < Formula
  desc "Userspace Go implementation of AmneziaWG"
  homepage "https://github.com/amnezia-vpn/amneziawg-go"
  license "MIT"
  url "https://github.com/amnezia-vpn/amneziawg-go.git",
       tag: "v0.2.12",
       revision: "2e3f7d122ca8ef61e403fddc48a9db8fccd95dbf"

  depends_on "go@1.22" => :build

  def install
    system "make", "PREFIX=#{prefix}", "install"
  end

  test do
    prog = "#{bin}/amneziawg-go -f notrealutun 2>&1"
    if OS.mac?
      assert_match "be utun", pipe_output(prog)
    else

      assert_match "Running amneziawg-go is not required because this", pipe_output(prog)
    end
  end
end
