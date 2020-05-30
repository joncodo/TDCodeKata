# frozen_string_literal: true

STRING_LINES_PER_NUMBER = 4
CHARACTER_LENGTH = 3

# OCR = Optical Character Recognition
# It converts non-standard, text-based digits into numbers that ruby can work with
class Ocr
  def initialize(file_path)
    @file_path = file_path
  end

  def extract_numbers
    raise 'File was invalid' unless valid?

    # since each line of digits is actually 4 lines of strings,
    # we need to divide the total lines by four to get an accurate counter
    extracted_numbers = []
    counter = 0
    while counter < File.readlines(@file_path).length / STRING_LINES_PER_NUMBER
      start_index = counter * STRING_LINES_PER_NUMBER
      end_index = counter * STRING_LINES_PER_NUMBER + CHARACTER_LENGTH
      extracted_number = read_single_line_of_numbers File.readlines(@file_path)[start_index..end_index]
      extracted_numbers << extracted_number
      counter += 1
    end
    extracted_numbers
  end

  # Sample input
  # [" _  _  _  _  _  _  _  _  _ ",
  #  "|_||_||_||_||_||_||_||_||_|",
  #  " _| _| _| _| _| _| _| _| _|",
  #  ""]
  def read_single_line_of_numbers(string_lines_array)
    digit_array = extract_digit_array(string_lines_array)
    account_number = ''
    digit_array.each do |digit|
      extracted_number = all_digits.each_index.select { |i| all_digits[i] == digit }
      account_number += extracted_number[0].to_s
    end
    account_number
  end

  # this produces an array of arrays where each element of the parent array contains 4 lines of strings that make up a single
  def extract_digit_array(string_lines_array)
    # this assumes that all account numbers will always be nine digits
    digit_array = [[], [], [], [], [], [], [], [], []]
    # im sure there is a better way to do this but I am going to leave it for now and come back if I have time
    string_lines_array.each do |line|
      digit_array[0] << sanitize_character_fragment(line[0..2])
      digit_array[1] << sanitize_character_fragment(line[3..5])
      digit_array[2] << sanitize_character_fragment(line[6..8])
      digit_array[3] << sanitize_character_fragment(line[9..11])
      digit_array[4] << sanitize_character_fragment(line[12..14])
      digit_array[5] << sanitize_character_fragment(line[15..17])
      digit_array[6] << sanitize_character_fragment(line[18..20])
      digit_array[7] << sanitize_character_fragment(line[21..23])
      digit_array[8] << sanitize_character_fragment(line[24..26])
    end
    digit_array
  end

  # some editors will add a new line to files where you dont want it
  # this removes the chance for that to happen
  def sanitize_character_fragment(fragment)
    return '   ' if fragment == "\n" || fragment.nil?

    fragment
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

  def all_digits
    [
      [
        ' _ ',
        '| |',
        '|_|',
        '   '
      ], [
        '   ',
        '  |',
        '  |',
        '   '
      ], [
        ' _ ',
        ' _|',
        '|_ ',
        '   '
      ], [
        ' _ ',
        ' _|',
        ' _|',
        '   '
      ], [
        '   ',
        '|_|',
        '  |',
        '   '
      ], [
        ' _ ',
        '|_ ',
        ' _|',
        '   '
      ], [
        ' _ ',
        '|_ ',
        '|_|',
        '   '
      ], [
        ' _ ',
        '  |',
        '  |',
        '   '
      ], [
        ' _ ',
        '|_|',
        '|_|',
        '   '
      ], [
        ' _ ',
        '|_|',
        ' _|',
        '   '
      ]
    ]
  end
end
