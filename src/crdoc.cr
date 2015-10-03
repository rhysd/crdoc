require "./crdoc/*"
require "./crdoc/command/*"

class Crdoc::App
  USAGE = <<-USAGE
Usage: crdoc [command] [options] [--help]

Command:
    search                      search all documents
    api                         search API name
    syntax_and_semantics        search 'Syntax and Semantics' documents
    list                        show list of all documents
    update                      update cache
USAGE

  CONFIG_PATH = "#{ENV["HOME"]}/.config/crdoc"

  def self.run(opts = ARGV)
    new(opts).run
  end

  def initialize(@options)
  end

  def usage
    puts USAGE
    true
  end

  def run
    if @options.includes? "--help"
      return usage
    end

    command = @options.first?
    if command
      @options.shift

      repo = Repository.new CONFIG_PATH
      repo.init
      docs = Documents.new(CONFIG_PATH, repo)

      case
      when "search".starts_with? command
        not_implemented
      when "api".starts_with? command
        not_implemented
      when "list".starts_with? command
        Command::List.new(docs).run(@options)
      when "update".starts_with? command
        repo.update
        not_implemented
      when "syntax_and_semantics".starts_with? command
        not_implemented
      else
        usage
      end
    else
      usage
    end
  end

  def not_implemented
    STDERR.puts "Sorry, this command is not implemented yet."
    false
  end
end
