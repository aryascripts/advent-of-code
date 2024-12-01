class ArraySorter
  def initialize(arr)
    @array = arr
  end

  def sort
    chunk_size = if @array.length < 10
      1
    else
      (@array.length / 10.0).ceil
    end

    splitted_sorted = []
    @array.each_slice(chunk_size) do |chunk|
      splitted_sorted.push chunk.sort
    end
    merge_sorted_chunks(splitted_sorted)
  end

  private

  def merge_sorted_chunks(chunks)
    result = []
    until chunks.empty?
      smallest_chunk = chunks.min_by { |chunk| chunk.first }
      result << smallest_chunk.shift
      chunks.reject!(&:empty?)
    end
    result
  end
end
