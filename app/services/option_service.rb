# frozen_string_literal: true

class OptionService
  attr_reader :cost

  def initialize
    rand(0..1000)
  end
end
