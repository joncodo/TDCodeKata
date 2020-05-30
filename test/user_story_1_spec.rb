# frozen_string_literal: true

require 'minitest/autorun'
require '../app/ocr'

LINE_LENGTH = 27
LINES_PER_CHARACTER = 4
SAMPLE_FILE_PATH = 'test/sample_data'

describe Ocr do
  before do
    @ocr = Ocr.new "#{SAMPLE_FILE_PATH}/many_account_numbers.txt"
  end

  describe 'extract_numbers' do
    it 'returns an array of numbers' do
      single_ocr = Ocr.new "#{SAMPLE_FILE_PATH}/single_account_number.txt"
      assert_equal ['123456789'], single_ocr.extract_numbers

      expected = ['000000000', '111111111', '222222222', '333333333', '444444444', '555555555', '666666666', '777777777', '888888888', '999999999', '123456789']
      assert_equal expected, @ocr.extract_numbers
    end
  end

  describe 'line_count' do
    it 'gets the number of lines in a file' do
      assert_equal 44, @ocr.line_count
    end
  end

  describe 'valid_line_count?' do
    it 'gets the number of lines in a file' do
      assert_equal true, @ocr.valid_line_count?

      bad_ocr = Ocr.new "#{SAMPLE_FILE_PATH}/invalid_lines.txt"
      assert_equal false, bad_ocr.valid_line_count?
    end
  end

  describe 'valid_character_count?' do
    it 'makes sure each line in the file has the correct number of characters' do
      assert_equal true, @ocr.valid_character_count?

      bad_ocr = Ocr.new "#{SAMPLE_FILE_PATH}/invalid_character_count.txt"
      assert_equal false, bad_ocr.valid_character_count?
    end
  end

  describe 'valid?' do
    it 'makes sure the file is valid' do
      assert_equal true, @ocr.valid?

      bad_ocr = Ocr.new "#{SAMPLE_FILE_PATH}/invalid_lines.txt"
      assert_equal false, bad_ocr.valid?

      bad_ocr2 = Ocr.new "#{SAMPLE_FILE_PATH}/invalid_character_count.txt"
      assert_equal false, bad_ocr2.valid?
    end
  end
end
