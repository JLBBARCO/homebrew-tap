class PasswordsManager < Formula
  desc "Password manager with encrypted local storage"
  homepage "https://github.com/JLBBARCO/passwords-manager"
  version "1.0.82"

  on_macos do
    url "https://github.com/JLBBARCO/passwords-manager/releases/download/v1.0.82/passwords-manager-macos.tar.gz"
    sha256 "f166dbb380c208b4d3f0da171781dd9d0b512c07305302c323787c9578c539ab"
  end

  on_linux do
    url "https://github.com/JLBBARCO/passwords-manager/releases/download/v1.0.82/passwords-manager-linux.tar.gz"
    sha256 "a0311b7103b34fd67e60771b037895955bc66641fe2a26e64554050cfad5a4d2"
  end

  def install
    bin.install "passwords-manager"
  end
end
