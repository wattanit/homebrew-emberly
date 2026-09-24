class Emberly < Formula
  desc "Emberly Code — an interactive AI coding agent for the terminal"
  homepage "https://github.com/wattanit/emberly-code"
  version "0.5.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/wattanit/emberly-code/releases/download/v0.5.3/emberly-aarch64-apple-darwin.tar.xz"
      sha256 "f979c270f1fb39d394f00b6a1e920a502d356a1d75a78ed5351362b5db834869"
    end
    if Hardware::CPU.intel?
      url "https://github.com/wattanit/emberly-code/releases/download/v0.5.3/emberly-x86_64-apple-darwin.tar.xz"
      sha256 "b4d2f34030b6160e55a26366c0cdd6234e5c17bb2c268156747deace2ac76f53"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wattanit/emberly-code/releases/download/v0.5.3/emberly-aarch64-unknown-linux-musl.tar.xz"
      sha256 "876522f68fcfbfb741de89e1048dfa9e97a0d31b6ae998f42ae732dcfeea069e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/wattanit/emberly-code/releases/download/v0.5.3/emberly-x86_64-unknown-linux-musl.tar.xz"
      sha256 "3941ef13a0cf75d5eba09b42e101f74c6587e5d2e1e3ba9c5c2adcc2f2b63e69"
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
