# frozen_string_literal: true

STRING_LINES_PER_NUMBER = 4

# OCR = Optical Character Recognition
# It converts non-standard, text-based digits into numbers that ruby can work with
class Ocr
  def initialize(file_path)
    @file_path = file_path
  end

  def extract_numbers
    raise 'File was invalid' unless valid?

    counter = 0

    # since each line of digits is actually 4 lines of strings,
    # we need to divide the total lines by four to get an accurate counter
    while counter < File.readlines(@file_path).length / STRING_LINES_PER_NUMBER
      start_index = counter * STRING_LINES_PER_NUMBER
      end_index = counter * STRING_LINES_PER_NUMBER + 3
      read_single_line_of_numbers File.readlines(@file_path)[start_index..end_index]
      counter += 1
    end
  end

  # Sample input
  # [" _  _  _  _  _  _  _  _  _ ",
  #  "|_||_||_||_||_||_||_||_||_|",
  #  " _| _| _| _| _| _| _| _| _|",
  #  ""]
  def read_single_line_of_numbers(string_lines_array)
    puts string_lines_array
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
