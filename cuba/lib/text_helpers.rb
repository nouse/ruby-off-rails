module TextHelpers
  def truncate(text, length=20)
    max_length = length.abs
    text.length > max_length ? "#{text[0..max_length]}..." : text
  end
end
