# frozen_string_literal: true

# OCR = Optical Character Recognition
# It converts non-standard, text-based digits into numbers that ruby can work with
class OCR
  def initialize(file_input)
    # Instance variables
    @file_input = file_input
  end

  def print_file
    puts @file_input
  end
end
