class LanguagePack::Helpers::BunInstaller
  attr_reader :version

  def self.hardcoded_bun
    version = "1.0.0"
    name = "bun-v#{version}"
    target = "bun-linux-x64-baseline.zip"
    {
      "number" => version,
      "url"    => "https://github.com/oven-sh/bun/releases/download/#{name}/#{target}"
    }
  end

  def initialize
    @version = "1.0.0"
    @url     = self.class.hardcoded_bun["url"]
    @fetcher = LanguagePack::Fetcher.new("")
  end

  def name
    "bun-v#{@version}"
  end

  def binary_path
    "#{name}/bin/"
  end

  def install
    Dir.mktmpdir do |dir|
      Dir.chdir(dir) do
        @fetcher.fetch_unzip(@url)
      end

      FileUtils.mv(File.join(dir, name), name)
    end
  end
end
