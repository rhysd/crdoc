module Crdoc::Repository extend self
  CONFIG_PATH = "#{ENV["HOME"]}/.config/crdoc"
  REPO_PATH = "#{CONFIG_PATH}/crystal"

  def exists?
    Dir.exists? REPO_PATH
  end

  def update
    return false unless exists?
    Dir.chdir REPO_PATH do
      system "git pull"
    end
  end

  def path
    REPO_PATH
  end

  def init
    Dir.mkdir_p CONFIG_PATH unless Dir.exists?(CONFIG_PATH)
    Dir.chdir CONFIG_PATH do
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

