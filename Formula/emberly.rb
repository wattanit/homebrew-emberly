class Emberly < Formula
  desc "Emberly Code — an interactive AI coding agent for the terminal"
  homepage "https://github.com/wattanit/emberly-code"
  version "0.5.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/wattanit/emberly-code/releases/download/v0.5.2/emberly-aarch64-apple-darwin.tar.xz"
      sha256 "bbabfd06a636f91c83ba24142e477071955b799d57dd03f5a9692aa30263f251"
    end
    if Hardware::CPU.intel?
      url "https://github.com/wattanit/emberly-code/releases/download/v0.5.2/emberly-x86_64-apple-darwin.tar.xz"
      sha256 "20d172bae9f142d983d66b7fb3f57b4d922138d0bef09c92c6617c4a370dfc7f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wattanit/emberly-code/releases/download/v0.5.2/emberly-aarch64-unknown-linux-musl.tar.xz"
      sha256 "1284afbb5c143d93b51489d69ded25261ccd7c66312a940e1818fc12bf583d8f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/wattanit/emberly-code/releases/download/v0.5.2/emberly-x86_64-unknown-linux-musl.tar.xz"
      sha256 "720268c2e5814d87fd93c6d97ebced360f5854cff21e12861f917e53879720a4"
    end
  end
  license "AGPL-3.0-or-later"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":               {},
    "aarch64-unknown-linux-gnu":          {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static":  {},
    "x86_64-apple-darwin":                {},
    "x86_64-unknown-linux-gnu":           {},
    "x86_64-unknown-linux-musl-dynamic":  {},
    "x86_64-unknown-linux-musl-static":   {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "emberly"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "emberly"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "emberly"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "emberly"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
