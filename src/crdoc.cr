require "./crdoc/*"

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

  def self.run(opts = ARGV)
    new(opts).run
  end

  def initialize(@options)
  end

  def run
    unless @options.includes? "--help"
      puts USAGE
      return
    end

    command = @options.first?
    if command
      @options.shift
      case
      when "search".starts_with? command
        not_implemented
      when "api".starts_with? command
        not_implemented
      when "list".starts_with? command
        not_implemented
      when "update".starts_with? command
        not_implemented
      when "syntax_and_semantics".starts_with? command
        not_implemented
      end
    else
      puts USAGE
    end
    nil
  end

  def not_implemented
    STDERR.puts "Sorry, this command is not implemented yet."
    nil
  end
end
