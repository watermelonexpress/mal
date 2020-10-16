def pr_str(mal)
  case mal
  when MalList
    "(#{mal.map{ |m| pr_str(m) }.join(" ")})"
  else
    mal.to_s
  end
end
