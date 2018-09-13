require 'spec_helper'
require 'highlights'

describe 'highlights' do
  describe '#highlight' do
    it 'returns the same string if no tokens are given' do
      expect(highlight('abc', [])).to eq 'abc'
    end

    it 'returns the same string if no tokens are found' do
      expect(highlight('abc', ['z'])).to eq 'abc'
    end

    it 'wraps the string when it matches the token' do
      expect(highlight('abc', ['abc'])).to eq '<b>abc</b>'
    end

    it 'wraps a token within the string' do
      expect(highlight('abc def ghi', ['def'])).to eq 'abc <b>def</b> ghi'
    end

    it 'wraps multiple tokens within the string' do
      expect(highlight('abcdefg', %w[ab fg])).to eq '<b>ab</b>cde<b>fg</b>'
    end

    it 'wraps multiple tokens within the string' do
      expect(highlight('abcdefg', %w[ab fg])).to eq '<b>ab</b>cde<b>fg</b>'
    end

    it 'does not confuses the string with used wrap tag' do
      expect(highlight('bab', ['b'])).to eq '<b>b</b>a<b>b</b>'
    end

    it 'ignores repeated tokens' do
      expect(highlight('bab', %w[b b])).to eq '<b>b</b>a<b>b</b>'
    end

    it 'joins continuous tags' do
      expect(highlight('ab', %w[b a])).to eq '<b>ab</b>'
    end

    it 'uses a single wrap when tokens intersect' do
      str = 'abcdefg'
      tokens = %w[bcde cde]
      highlighted = 'a<b>bcde</b>fg'
      expect(highlight(str, tokens)).to eq highlighted
    end

    it 'wraps the whole str if token matches every char' do
      str = 'abc'
      tokens = %w[a b c]
      highlighted = '<b>abc</b>'
      expect(highlight(str, tokens)).to eq highlighted
    end
  end

  describe '#flatten' do
    it 'returns a flattened str' do
      expect(flatten('0{{34}}7')).to eq '0{34}7'
      expect(flatten('a{a{a}a{a}{a}a}a')).to eq 'a{aaaaaa}a'
    end 
  end
end
