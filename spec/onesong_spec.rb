require_relative 'spec_helper'

describe Kernel do
  def self.get_requires
    Dir[File.dirname(__FILE__) + '/../lib/onesong/**/*.rb']
  end

  # Try to require each of the files in Onesong
  get_requires.each do |r|
    it "should require #{r}" do

      # A require returns true if it was required, false if it had already been
      # required, and nil if it couldn't require.
      Kernel.require(r.to_s).should_not be_nil
    end
  end
end

describe Onesong do
  it "should have a VERSION constant" do
    Onesong.const_defined?('VERSION').should be_true
  end
end
