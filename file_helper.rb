# frozen_string_literal: true

class FileHelper
  def initialize(file)
    @file = file
  end

  def list
    @list ||= file_stream.readlines.map(&:chomp)
  end

  def split(delimiter)
    file_stream.read.split(delimiter)
  end

  private

  def file_stream
    File.open(@file)
  end
end
