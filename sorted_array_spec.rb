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

      describe :map do
        it 'the original array should not be changed' do
          original_array = sorted_array.internal_arr
          expect { sorted_array.map {|el| el } }.to_not change { sorted_array }
        end

        it_should_behave_like "yield to all elements in sorted array", :map

        it 'creates a new array containing the values returned by the block' do
          expect { (1..10).map {|x| x*2} } == [2,4,6,8,10,12,14,16,18,20]
          #pending "fill this spec in with a meaningful example"
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
          expect { original_array.map! {|el| el * 2 } } == [2,4,6,8,10,12,14,18,16]
        end
      end
    end
  end

  describe :find do
    it "find first odd element" do
      expect { sorted_array.find {|x| x % 2 == 0} } == 3
      #pending "define some examples by looking up http://www.ruby-doc.org/core-2.1.0/Enumerable.html#method-i-find"
    end
  end

  describe :inject do
    specify do 
      expect do |b| 
        block_with_two_args = Proc.new { |acc, el| return true }
        sorted_array.send(method, block_with_two_args) 
      end.to yield_successive_args( [0,2], [2,3], [5,4], [9, 7], [16,9])
    end

    it "numeric inject" do
      expect { (1..10).inject(0) { |sum, x| sum+x } } == 55
      #pending "define some examples by looking up http://www.ruby-doc.org/core-2.1.0/Enumerable.html#method-i-inject"
    end

    it "string" do
      expect { ["h","e","l","l","o"].inject("") { |sum, x| sum+x } } == "hello"
      #pending "define some examples by looking up http://www.ruby-doc.org/core-2.1.0/Enumerable.html#method-i-inject"
    end
  end
end
