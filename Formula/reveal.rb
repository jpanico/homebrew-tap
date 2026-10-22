class Reveal < Formula
  desc "Handler for reveal: links, which select a file in Finder"
  homepage "https://github.com/jpanico/reveal"
  url "https://github.com/jpanico/reveal/archive/refs/tags/v1.0.1.tar.gz"
  sha256 "43995944833e1af85900f6a385028ee16232ad605baa12acdb2f9307a62160fa"
  license "MIT"
  head "https://github.com/jpanico/reveal.git", branch: "main"

  depends_on macos: :sonoma

  def install
    system "make", "build"
    prefix.install "build/Reveal.app"
  end

  # Reveal runs all the time, so that it sees the click behind each link. At
  # each start it registers itself with Launch Services, for reveal: links,
  # and with the Services menu; a post-install step can't, as Launch Services
  # refuses requests from Homebrew's sandbox.
  service do
    run opt_prefix/"Reveal.app/Contents/MacOS/Reveal"
    keep_alive true
    process_type :interactive
  end

  test do
    app = prefix/"Reveal.app"
    assert_predicate app/"Contents/MacOS/Reveal", :executable?
    scheme = shell_output("/usr/libexec/PlistBuddy -c " \
                          "'Print :CFBundleURLTypes:0:CFBundleURLSchemes:0' " \
                          "#{app}/Contents/Info.plist")
    assert_equal "reveal", scheme.strip
    system "codesign", "--verify", app
  end
end
