require 'rspec'
require './sorted_array.rb'

shared_examples "yield to all elements in sorted array" do |method|
    specify do 
      expect do |b| 
        sorted_array.send(method, &b) 
      end.to yield_successive_args(2,3,4,7,9) 
    end
end

describe SortedArray do
  let(:source) { [2,3,4,7,9] }
  let(:sorted_array) { SortedArray.new source }

  describe "iterators" do
    describe "that don't update the original array" do 
      describe :each do
        context 'when passed a block' do
          it_should_behave_like "yield to all elements in sorted array", :each
        end

        it 'should return the array' do
          sorted_array.each {|el| el }.should eq source
        end
      end
 
      describe :each_with_index do
        context 'when passed a block' do
          it_should_behave_like "yield to all elements in sorted array", :each_with_index
        end

        it 'should return the array' do
          sorted_array.each_with_index {|el,i| el }.should == source
        end
      end

      describe :map do
        it 'the original array should not be changed' do
          original_array = sorted_array.internal_arr
          expect { sorted_array.map {|el| el } }.to_not change { sorted_array }
        end

        it_should_behave_like "yield to all elements in sorted array", :map

        it 'creates a new array containing the values returned by the block' do
          (1..10).map {|x| x*2}.should == [2,4,6,8,10,12,14,16,18,20]
        end
      end
    end

    describe "that update the original array" do
      describe :map! do
        it 'the original array should be updated' do
          original_array = [1,2,3,4,5,6,7,9,8]
          expect { original_array.map! {|el| el * 2 } }.to change { original_array }
        end

        it_should_behave_like "yield to all elements in sorted array", :map!

        it 'should replace value of each element with the value returned by block' do
          original_array = [1,2,3,4,5,6,7,9,8]
          original_array.map! {|el| el * 2 }.should == [2,4,6,8,10,12,14,18,16]
        end
      end
    end
  end

  describe :find do
    it "find first odd element" do
      sorted_array.find { |x| x % 2 != 0 }.should == 3
    end

    it "find 4" do
      sorted_array.find { |x| x == 4 }.should == 4
    end

    it "find element not there" do
      sorted_array.find { |x| x == 100 }.should == nil
    end
  end

  describe :inject do
    # specify do 
    #   expect do |b| 
    #     block_with_two_args = Proc.new { |acc, el| return true }
    #     sorted_array.send(method, block_with_two_args) 
    #   end.to yield_successive_args( [0,2], [2,3], [5,4], [9, 7], [16,9])
    # end

    it "numeric inject" do
      (1..10).inject(0) { |sum, x| sum+x }.should == 55
    end

    it "numeric inject 2 - acc=nil" do
      (1..10).inject { |sum, x| sum+x }.should == 55
    end

    it "numeric inject 2 - multiplication with acc= a number" do
      (1..10).inject(1) { |prod, x| prod*x }.should == 3628800
    end

    it "numeric inject 3 - multiplication with acc = nil" do
      (1..10).inject { |prod, x| prod*x }.should == 3628800
    end

    it "with sorted_array - acc = 1 - product" do
      sorted_array.inject(1) { |prod,x| prod*x }.should == 1512
    end
    
    it "with sorted_array - acc = nil - product" do
      sorted_array.inject { |prod,x| prod*x }.should == 1512
    end

    it "with sorted_array - acc = 0 - sum" do
      sorted_array.inject(0) { |sum,x| sum + x }.should == 25
    end

    it "with sorted_array - acc = nil - sum" do
      sorted_array.inject { |sum,x| sum + x }.should == 25
    end

    it "string" do
      sorted_array = SortedArray.new(["h","e","l","l","o"])
      sorted_array.inject("") { |sum, x| sum+x }.should == "ehllo"
    end

    it "string 2 - acc = nil" do
      sorted_array = SortedArray.new(["h","e","l","l","o"])
      sorted_array.inject { |sum, x| sum+x }.should == "ehllo"
    end
  end
end
