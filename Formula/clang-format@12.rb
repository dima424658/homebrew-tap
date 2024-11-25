class ClangFormatAT12 < Formula
  desc "Formatting tools for C, C++, Obj-C, Java, JavaScript, TypeScript"
  homepage "https://clang.llvm.org/docs/ClangFormat.html"
  license "Apache-2.0"
  head "https://github.com/llvm/llvm-project.git", branch: "llvmorg-12.0.1"

  depends_on "cmake" => :build

  uses_from_macos "libxml2"
  uses_from_macos "ncurses"
  uses_from_macos "python", since: :catalina
  uses_from_macos "zlib"

  resource "clang" do
    url "https://github.com/llvm/llvm-project/releases/download/llvmorg-12.0.1/clang-12.0.1.src.tar.xz"
    sha256 "6e912133bcf56e9cfe6a346fa7e5c52c2cde3e4e48b7a6cc6fcc7c75047da45f"
  end

  def install
    (buildpath/"tools/clang").install resource("clang")

    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build", "--target", "clang-format"

    bin.install buildpath/"build/bin/clang-format" => "clang-format-12"
    bin.install buildpath/"tools/clang/tools/clang-format/git-clang-format" => "git-clang-format-12"
  end

  test do
    # NB: below C code is messily formatted on purpose.
    (testpath/"test.c").write <<~EOS
      int         main(char *args) { \n   \t printf("hello"); }
    EOS

    assert_equal "int main(char *args) { printf(\"hello\"); }\n",
        shell_output("#{bin}/clang-format-12 -style=Google test.c")
  end
end