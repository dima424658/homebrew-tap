class TarantoolAT15 < Formula
  desc "In-memory database and Lua application server"
  homepage "https://tarantool.org/"
  url "https://dist.tarantool.io/stable.old/tarantool-1.5.5-33-g38b2398-src.tar.gz"
  version "1.5.5-33"
  sha256 "f78d38866eb4c4e8612e6a8c0a1911a6355e1535fd9b572ee2a6835979eabfc5"
  license "BSD-2-Clause"
  head "https://github.com/tarantool/tarantool.git", branch: "1.5.5"

  depends_on "cmake" => :build
  depends_on "readline"

  patch do
    url "https://raw.githubusercontent.com/dima424658/homebrew-clang/main/Patches/tarantool15/0001-fix-compilation-issues.patch"
    sha256 "b9c0a8f9d3b3a5b9da2e04168875541465e468c34e0adf01fe8f1216150ee022"
  end

  def install
    inreplace "test/share/tarantool_dmg.cfg", /^pid_file =.*/, "pid_file = #{var}/run/box.pid"
    inreplace "test/share/tarantool_dmg.cfg", /^work_dir =.*/, "work_dir = #{var}/lib/tarantool"

    args = std_cmake_args
    args << "-DCMAKE_INSTALL_MANDIR=#{doc}"
    args << "-DCMAKE_INSTALL_SYSCONFDIR=#{etc}"
    args << "-DCMAKE_INSTALL_LOCALSTATEDIR=#{var}"
    args << "-DENABLE_CLIENT=ON"

    system "cmake", ".", *args
    system "make"
    system "make", "install"
  end

  def post_install
    (var/"lib/tarantool").mkpath
    (var/"log/tarantool").mkpath
  end

  test do
    system bin/"tarantool_box", "--version"
  end
end
