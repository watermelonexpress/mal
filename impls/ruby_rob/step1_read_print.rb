require_relative 'reader'
require_relative 'printer'

def READ(string)
  read_str(string)
end

def EVAL(string)
  string
end

def PRINT(mal)
  pr_str(mal)
end

def rep(string)
  PRINT(EVAL(READ(string)))
end

while true
  print 'users> '
  input = gets
  unless input
    puts
    break
  end
  puts rep(input)
end
