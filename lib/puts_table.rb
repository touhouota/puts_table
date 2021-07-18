# frozen_string_literal: true

# Display the Array contain Hash as show like a table.
module PutsTable
  def puts_table(array)
    @array = array

    write_devide
    write_header
    write_devide
    array.each { |item| write_item(item) }
    write_devide

    @array = nil
  end

  private

  def array_status
    return @array_status if defined? @array_status

    keys = @array.first.keys
    @array_status = keys.each_with_object({}) do |key, result|
      result[key] = {
        key: key,
        width: [@array.map { |hash| hash[key].to_s.size }.max, key.to_s.size].max
      }
    end
  end

  def write_devide
    puts "+-#{array_status.map { |_, h| '-' * h[:width] }.join('-+-')}-+"
  end

  def write_header
    str = array_status.map { |k, h| k.to_s.ljust(h[:width]) }.join(' | ')
    puts "| #{str} |"
  end

  def write_item(item)
    str = item.map { |k, v| v.to_s.ljust(array_status.dig(k, :width)) }.join(' | ')
    puts "| #{str} |"
  end
end

class Object
  include PutsTable
end
