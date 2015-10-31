require "./repository"
require "json"

class Crdoc::Documents
  class Cache
    JSON.mapping({
      api: {type: Hash(String, String), nilable: false},
      syntax_and_semantics: {type: Hash(String, String), nilable: false},
    })

    def to_hash
      {
        api: @api,
        syntax_and_semantics: @syntax_and_semantics,
      }
    end
  end

  def initialize(@config_path, @repo : Crdoc::Repository)
    @cache_file = "#{@config_path}/cache"
  end

  def cached?
    File.exists? @cache_file
  end

  def delete_cache
    File.delete @cache_file if cached?
  end

  private def load_cache
    begin
      Cache.from_json(File.read(@cache_file)).to_hash
    rescue e
      puts "ERROR!"
      puts e
      {} of String => Hash(String, String)
    end
  end

  def cache
    if cached?
      load_cache
    else
      cache!
    end
  end

  private def paths_to_cache(paths, prefix_len)
    cache = {} of String => String
    paths.each do |p|
      begin
        # -6 means slice out '.html' extension
        cache[p[prefix_len..-6]] = p
      rescue e
        STDERR.puts "Invalid cache path: #{e}"
      end
    end
    cache
  end

  def cache!
    @repo.init

    api_path = "#{@repo.path}/api/"
    syntax_and_semantics_path = "#{@repo.path}/docs/syntax_and_semantics/"

    api = Dir["#{api_path}**/*.html", "#{api_path}*.html"]
    syntax_and_semantics = Dir["#{syntax_and_semantics_path}**/*.html", "#{syntax_and_semantics_path}*.html"]

    cache = {
      api: paths_to_cache(api, api_path.size),
      syntax_and_semantics: paths_to_cache(syntax_and_semantics, syntax_and_semantics_path.size),
    }

    File.open(@cache_file, mode = "w") do |f|
      cache.to_json f
    end
    cache
  end

  def candidates(kind = nil)
    if kind
      cache[kind]
    else
      cache.inject({} of String => String) do |acc, _, v|
        acc.merge! v
      end
    end
  end

  def list(kind = nil: Symbol?)
    c = cache
    if kind
      c[kind].map{|k, _| k}
    else
      s = c.inject(0){|i, _, v| i + v.size}
      c.inject(Array(String).new s) do |acc, _, v|
        acc + v.map{|k, _| k}
      end
    end
  end

  def list_paths(kind = nil: Symbol?)
    c = cache
    if kind
      c[kind].map{|_, v| v}
    else
      s = c.inject(0){|i, _, v| i + v.size}
      c.inject(Array(String).new s) do |acc, _, v|
        acc + v.map{|_, v| v}
      end
    end
  end

  # Currently returns only first candidate
  def search(kind = nil: Symbol?)
  end
end
