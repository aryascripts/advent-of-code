require_relative './../utils/array_sorter'

describe ArraySorter do
  it "sorts the array" do
    unsorted = [8,6,7,4,3,2,5,1,9,0,10,16,17,13,19,12,15,11,18,14,20]
    sorter = ArraySorter.new(unsorted)
    expect(sorter.sort).to match_array([0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20])
  end

  it "sorts the array with duplicate elements" do
    array_with_duplicates = [8,6,7,4,3,2,5,1,9,0,10,16,17,13,19,12,15,11,18,14,20,8,6,7,4,3,2,5,1,9,0,10,16,17,13,19,12,15,11,18,14,20]
    sorter = ArraySorter.new(array_with_duplicates)
    expect(sorter.sort).to match_array([0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7,8,8,9,9,10,10,11,11,12,12,13,13,14,14,15,15,16,16,17,17,18,18,19,19,20,20])
  end
end
