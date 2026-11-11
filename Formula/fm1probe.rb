class Fm1probe < Formula
  desc "Inspect, check, monitor, simulate and update M-VAVE FM-1 synthesisers"
  homepage "https://github.com/ocean/FM1Kit"
  license "MIT"
  head "https://github.com/ocean/FM1Kit.git", branch: "main"

  # The stable url and sha256 arrive with the first FM1Kit release that has `fm1probe --version`.

  depends_on xcode: ["16.3", :build]
  depends_on macos: :sonoma

  def install
    system "swift", "build", "--disable-sandbox", "--configuration", "release", "--product", "fm1probe"
    # FM1Rescue finds its flash loaders in this bundle, next to the binary.
    libexec.install ".build/release/fm1probe", ".build/release/FM1Kit_FM1Rescue.bundle"
    bin.install_symlink libexec/"fm1probe"
  end

  test do
    assert_match "fm1probe", shell_output("#{bin}/fm1probe --version")
    # A backup of a simulated FM-1 in download mode loads the bundled flash loaders and talks to no device.
    system bin/"fm1probe", "flash-backup", testpath/"backup", "--simulated"
    assert_predicate testpath/"backup", :directory?
  end
end
