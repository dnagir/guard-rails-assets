require 'spec_helper'
require 'guard/rails-assets'

describe Guard::RailsAssets do
  let(:options) { {} }
  subject { Guard::RailsAssets.new(['watchers'], options) }

  it 'should be able to create guard' do
    ::Guard::RailsAssets.new(['watchers'], {:options=>:here}).should_not be_nil
  end

  describe '#start' do
    it_behaves_like 'guard command', :command => :start, :run => true
  end

  describe '#reload' do
    it_behaves_like 'guard command', :command => :reload, :run => false
  end

  describe '#run_all' do
    it_behaves_like 'guard command', :command => :run_all, :run => true
  end

  describe '#run_on_change' do
    it_behaves_like 'guard command', :command => :run_on_change, :run => true
  end


  describe 'asset compilation' do
    it 'should notify on success'
    it 'should notify on failure'
  end
end
