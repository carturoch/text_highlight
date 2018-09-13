def highlight(str, tokens)
  return str if tokens.empty?
  tokenized = tokens.uniq.reduce(str) do |tokenized, token|
    tokenized.gsub(token, "{#{token}}")
  end.gsub('}{', '')
  tokenized = flatten(tokenized)
  correct_marks(tokenized)
end

def flatten(str)
  flat = []
  open_count = 0
  str.each_char do |char|
    if char == '{'
      flat << char unless open_count > 0
      open_count += 1
    elsif char == '}'
      flat << char unless open_count > 1
      open_count -= 1
    else
      flat << char
    end
  end
  flat.join('')
end

def correct_marks(str)
  str.gsub('{', '<b>').gsub('}', '</b>')
end