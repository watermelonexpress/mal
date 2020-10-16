require_relative 'types'

class Reader

  def initialize(tokens)
    @tokens = tokens
    @position = 0
  end

  def next
    token = peek
    @position += 1
    # @position = (@tokens.size - 1) if @position > @tokens.size
    token
  end

  def peek
    @tokens[@position]
  end
end

def tokenize(string)
  dont_touch_this = /[\s,]*(~@|[\[\]{}()'`~^@]|"(?:\\.|[^\\"])*"?|;.*|[^\s\[\]{}('"`,;)]*)/
  string.scan(dont_touch_this).flatten
end

def read_str(string)
  tokens = tokenize(string)
  reader = Reader.new(tokens)
  read_form(reader)
end

def read_form(reader)
  case reader.peek
  when '('
    read_list(reader)
  else
    read_atom(reader)
  end
end

def read_list(reader)
  reader.next
  list = MalList.new
  while reader.peek != ')'
    break if reader.peek.nil?
    list << read_form(reader)
  end
  reader.next

  list
end

def read_atom(reader)
  reader.next.to_sym
end
