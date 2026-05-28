class PasswordsManager < Formula
  desc "Password manager with encrypted local storage"
  homepage "https://github.com/JLBBARCO/passwords-manager"
  version "1.0.80"

  on_macos do
    url "https://github.com/JLBBARCO/passwords-manager/releases/download/v1.0.80/passwords-manager-macos.tar.gz"
    sha256 "146b69d8b5b7a5bfc345abcb2c00ac8fe6b07508250d6cb8aecd1a19e0000822"
  end

  on_linux do
    url "https://github.com/JLBBARCO/passwords-manager/releases/download/v1.0.80/passwords-manager-linux.tar.gz"
    sha256 "e613ad5035ec036f280a9088aaad15261ec42b5223e2ce08f2fa2feb69c9de8d"
  end

  def install
    bin.install "passwords-manager"
  end
end
