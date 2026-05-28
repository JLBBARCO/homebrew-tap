class PasswordsManager < Formula
  desc "Password manager with encrypted local storage"
  homepage "https://github.com/JLBBARCO/passwords-manager"
  version "1.0.81"

  on_macos do
    url "https://github.com/JLBBARCO/passwords-manager/releases/download/v1.0.81/passwords-manager-macos.tar.gz"
    sha256 "349a6f757263d5b5898f475aac777c38add68fe4c6047a689aa512e8186357ab"
  end

  on_linux do
    url "https://github.com/JLBBARCO/passwords-manager/releases/download/v1.0.81/passwords-manager-linux.tar.gz"
    sha256 "77522108e92f87f00add538d7647a0282ea6940d8e1b7a3881fb0efe512c318d"
  end

  def install
    bin.install "passwords-manager"
  end
end
