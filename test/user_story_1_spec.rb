# frozen_string_literal: true

require 'minitest/autorun'
require '../app/bank_ocr'

LINE_LENGTH = 27
LINES_PER_CHARACTER = 4

describe OCR do
  before do
    @ocr = OCR.new 'abd123'
  end

  describe 'sample test' do
    it 'should have at least one test pass' do
      assert_equal true, true
    end
  end

  describe 'when reading a file' do
    it 'gets all the account numbers in an array' do
      skip 'test this later'
    end
    it 'makes sure all the data is in the expected format' do
      skip 'test this later'
    end
  end
end
