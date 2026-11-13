class Fm1probe < Formula
  desc "Inspect, check, monitor, simulate and update M-VAVE FM-1 synthesisers"
  homepage "https://github.com/ocean/FM1Kit"
  url "https://github.com/ocean/FM1Kit/archive/refs/tags/0.7.0.tar.gz"
  sha256 "94a5ff2ffb5920a23c144d2673e32995e8193ea046bbf99ce6bcb50ef74787a3"
  license "MIT"
  head "https://github.com/ocean/FM1Kit.git", branch: "main"

  depends_on xcode: ["16.3", :build]
  depends_on macos: :sonoma

  def install
    system "swift", "build", "--disable-sandbox", "--configuration", "release", "--product", "fm1probe"
    bin.install ".build/release/fm1probe"
  end

  test do
    assert_match "fm1probe", shell_output("#{bin}/fm1probe --version")
    # A backup of a simulated FM-1 in download mode uses the built-in flash loader and talks to no device.
    system bin/"fm1probe", "flash-backup", testpath/"backup", "--simulated"
    assert_predicate testpath/"backup", :directory?
  end
end
