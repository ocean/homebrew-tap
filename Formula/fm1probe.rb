class Fm1probe < Formula
  desc "Inspect, check, monitor, simulate and update M-VAVE FM-1 synthesisers"
  homepage "https://github.com/ocean/FM1Kit"
  url "https://github.com/ocean/FM1Kit/archive/refs/tags/0.8.0.tar.gz"
  sha256 "8931aecb269c920c35e605a90f208b8bbbd4d3a8e3a19378753b651784f090b0"
  license "MIT"
  head "https://github.com/ocean/FM1Kit.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/ocean/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "8d4db283068cb3f9dc81c61e91160ac9457a9d2bbd971eb8adefe5d9758993b2"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "e6acf563d2540fea077e0e9a273da6600cdccdac627aeb8d3cb2672599f6f3d6"
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
