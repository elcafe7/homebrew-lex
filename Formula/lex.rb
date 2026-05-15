class Lex < Formula
  desc "The Elegant Bible Terminal - CLI tool for Bible study"
  homepage "https://github.com/elcafe7/lex"
  url "https://github.com/elcafe7/lex/archive/refs/tags/v2.4.5.tar.gz"
  sha256 "05e3079380d6aef2d52ca4858a1b14985528fa0b43074172562da2b4c06ebb75"
  license "MIT"

  depends_on "python@3.12"

  def install
    # Install into a private directory to avoid system-wide library pollution
    venv = virtualenv_create(libexec, "python3.12")
    
    # Install dependencies from requirements.txt
    if File.exist?("requirements.txt")
      venv.pip_install File.read("requirements.txt").split("\n")
    end

    # Install the main executable
    # We rename lex.py to lex during installation
    bin.install "lex.py" => "lex"
    
    # Ensure the script uses the virtualenv's python
    rewrite_shebang Formula["python@3.12"].opt_bin/"python3.12", bin/"lex"
  end

  test do
    # Simple test to verify the command runs
    output = shell_output("#{bin}/lex --help")
    assert_match "Bible", output
  end
end
