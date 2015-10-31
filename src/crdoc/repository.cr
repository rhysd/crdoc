class Crdoc::Repository
  def initialize(@config_path)
    @repo_path = "#{@config_path}/crystal"
  end

  def exists?
    Dir.exists? @repo_path
  end

  def update
    return false unless exists?
    Dir.cd @repo_path do
      system "git pull"
    end
  end

  def path
    @repo_path
  end

  def init
    Dir.mkdir_p @config_path unless Dir.exists?(@config_path)
    Dir.cd @config_path do
      system "git clone -b gh-pages --single-branch https://github.com/manastech/crystal.git"
    end unless exists?
  end

  def update!
    if exists?
      update
    else
      init
    end
  end
end

