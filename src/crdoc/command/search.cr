require "option_parser"

class Crdoc::Command::List
  def initialize(@docs, @kind = nil)
  end

  def kind
    if @kind
      @kind.to_s
    else
      "search"
    end
  end

  def run(args)
    feeling_lucky = false

    OptionParser.parse(args) do |parser|
      parser.banner = "crdoc #{kind} keywords..."
      parser.on("-f", "--feeling-lucky", "Open firstly found candidate") do
        feeling_lucky = true
      end
    end

    if args.empty?
      STDERR.puts "No search keyword is specified"
      return false
    end

    l = @docs.list(@kind).select do |c|
      args.all? do |a|
        c.includes? a
      end
    end

    if l.empty?
      puts "No result for #{args}"
      return true
    end

    if feeling_lucky
      puts l.first
    else
      puts l.first
    end
  end
end
