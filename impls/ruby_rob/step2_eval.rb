require_relative 'reader'
require_relative 'printer'

repl_env = {
  :+ => lambda {|a,b| a + b},
  :- => lambda {|a,b| a - b},
  :* => lambda {|a,b| a * b},
  :/ => lambda {|a,b| a / b}
}

def READ(string)
  read_str(string)
end

def EVAL(data, env)
  # string
  ast = eval_ast(data, env)
  return ast unless data.is_a? MalList
  return data if data.empty?
  operator = ast.shift
  operator.call(*ast)
end

def eval_ast(ast, env)
  case ast
  when Symbol
    if env[ast].nil?
      raise StandardError.new 'not found'
    end
    env[ast]
  when MalList
    ast.map { |i| EVAL(i, env) }
  else
    ast
  end
end

def PRINT(mal)
  pr_str(mal)
end

def rep(string, env)
  PRINT(EVAL(READ(string), env))
end

while true
  print 'users> '
  input = gets
  unless input
    puts
    break
  end
  begin
    puts rep(input, repl_env)
  rescue StandardError => e
    puts "received exception: #{e}"
  end
end
