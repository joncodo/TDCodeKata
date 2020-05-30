# frozen_string_literal: true

# OCR = Optical Character Recognition
# It converts non-standard, text-based digits into numbers that ruby can work with
class Ocr
  def initialize(file_path)
    @file_path = file_path
  end

  def read
    file = File.open(@file_path)
    file.read
  end

  def valid?
    valid_character_count? && valid_line_count?
  end

  def line_count
    File.open(@file_path, &:count)
  end

  def valid_line_count?
    (line_count % 4).zero?
  end

  def valid_character_count?
    valid = true
    File.readlines(@file_path).each do |line|
      # for some reason, a blank line evaluates to 1 and a 27 character line evaluates to 28
      line_length = line.length - 1
      valid = false if line_length != 27 && line_length != 0
    end
    valid
  end
end
