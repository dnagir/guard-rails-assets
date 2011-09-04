require 'spec_helper'

describe Guard::RailsAssets::RailsRunner do

  it 'should be tested properly as a Rails engine'
  
  it { should respond_to :compile_assets }
end
