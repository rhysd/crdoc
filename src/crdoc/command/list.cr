require "option_parser"

class Crdoc::Command::List
  def initialize(@docs)
  end

  def run(args)
    kind = nil

    OptionParser.parse(args) do |parser|
      parser.banner = "crdoc list"
      parser.on("-a", "--api", "lists all API candidates") do
        kind = :api
      end
      parser.on("-s", "--syntax-and-semantics", "lists all language spec candiadtes") do
        kind = :syntax_and_semantics
      end
    end

    l = @docs.list kind
    l.each{|c| puts c}
    true
  end
end
