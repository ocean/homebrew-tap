class Fm1probe < Formula
  desc "Inspect, check, monitor, simulate and update M-VAVE FM-1 synthesisers"
  homepage "https://github.com/ocean/FM1Kit"
  url "https://github.com/ocean/FM1Kit/archive/refs/tags/0.7.1.tar.gz"
  sha256 "6e9239624e1ad8f7ce906ef0ed6b80df6685d29d46f14e5c6c639c6c3086d7eb"
  license "MIT"
  head "https://github.com/ocean/FM1Kit.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/ocean/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "4bfa40c14a338b05f0641692bac2cf7e76a1a96ba8f1ec8c48952fbeccc40994"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "5e17361ca667bdf870229258d52c608a598fc881e821928281f87715d8752d52"
  end

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
