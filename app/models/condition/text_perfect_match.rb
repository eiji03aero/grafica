module Condition
  class TextPerfectMatch < Base
    property :text

    def calc_confidence(sequence)
      case sequence.text
      when text
        Score::MATCH
      else
        Score::NO_MATCH
      end
    end
  end
end
