class TextNode < Node
  property :text, default: ''

  def generate_reply_data(sequence)
    [
      { text: text }
    ]
  end
end
