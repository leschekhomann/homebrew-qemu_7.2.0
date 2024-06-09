
class Qemu < Formula
  desc "Emulator for x86 and PowerPC"
  homepage "https://www.qemu.org/"
  url "https://download.qemu.org/qemu-7.2.0.tar.xz"
  sha256 "5b49ce2687744dad494ae90a898c52204a3406e84d072482a1e1be854eeb2157"
  license "GPL-2.0-only"
  head "https://git.qemu.org/git/qemu.git", branch: "stable-7.2"

  bottle do
    sha256 arm64_ventura:  "fa987f9dc770812c58333c910cb0f5c4e730d513a1568cc4d6a215dfa3ac82d1"
    sha256 arm64_monterey: "62bea721ff6fa3ee15ed53ee8215fea42b2cd07e8fb39b77ce8e39f30287576f"
    sha256 arm64_big_sur:  "9b2c3aa359719358370901d00a1b9323459ec9af3add371d212fd98071418e6b"
    sha256 ventura:        "b4ae1b25edf4276936ad69d9399cf117a28cd49e212b0467c4cb6c22a7074f86"
    sha256 monterey:       "6a32684edc7ed07358a8b9b602198d69a45902ec7c72230caf5c9b9b8b5e7f10"
    sha256 big_sur:        "c327dffc16102993ab7fb81a2bbad0035af6af3e550a4095db72fcb8aff56ae8"
    sha256 x86_64_linux:   "05ece9acbbb003a7e8035f18f5193ae7c9caffacd60a744eac629de4a545aea4"
  end

  depends_on "libtool" => :build
  depends_on "glib"

  def install
    ENV["LIBTOOL"] = "glibtool"
    system "./configure"
    system "make", "install"
  end

  test do
    expected = build.stable? ? version.to_s : "QEMU Project"
    assert_match expected, shell_output("#{bin}/qemu-system-aarch64 --version")
    assert_match expected, shell_output("#{bin}/qemu-system-alpha --version")
    assert_match expected, shell_output("#{bin}/qemu-system-arm --version")
    assert_match expected, shell_output("#{bin}/qemu-system-cris --version")
    assert_match expected, shell_output("#{bin}/qemu-system-hppa --version")
    assert_match expected, shell_output("#{bin}/qemu-system-i386 --version")
    assert_match expected, shell_output("#{bin}/qemu-system-m68k --version")
    assert_match expected, shell_output("#{bin}/qemu-system-microblaze --version")
    assert_match expected, shell_output("#{bin}/qemu-system-microblazeel --version")
    assert_match expected, shell_output("#{bin}/qemu-system-mips --version")
    assert_match expected, shell_output("#{bin}/qemu-system-mips64 --version")
    assert_match expected, shell_output("#{bin}/qemu-system-mips64el --version")
    assert_match expected, shell_output("#{bin}/qemu-system-mipsel --version")
    assert_match expected, shell_output("#{bin}/qemu-system-nios2 --version")
    assert_match expected, shell_output("#{bin}/qemu-system-or1k --version")
    assert_match expected, shell_output("#{bin}/qemu-system-ppc --version")
    assert_match expected, shell_output("#{bin}/qemu-system-ppc64 --version")
    assert_match expected, shell_output("#{bin}/qemu-system-riscv32 --version")
    assert_match expected, shell_output("#{bin}/qemu-system-riscv64 --version")
    assert_match expected, shell_output("#{bin}/qemu-system-rx --version")
    assert_match expected, shell_output("#{bin}/qemu-system-s390x --version")
    assert_match expected, shell_output("#{bin}/qemu-system-sh4 --version")
    assert_match expected, shell_output("#{bin}/qemu-system-sh4eb --version")
    assert_match expected, shell_output("#{bin}/qemu-system-sparc --version")
    assert_match expected, shell_output("#{bin}/qemu-system-sparc64 --version")
    assert_match expected, shell_output("#{bin}/qemu-system-tricore --version")
    assert_match expected, shell_output("#{bin}/qemu-system-x86_64 --version")
    assert_match expected, shell_output("#{bin}/qemu-system-xtensa --version")
    assert_match expected, shell_output("#{bin}/qemu-system-xtensaeb --version")
    resource("homebrew-test-image").stage testpath
    assert_match "file format: raw", shell_output("#{bin}/qemu-img info FLOPPY.img")
  end
end
