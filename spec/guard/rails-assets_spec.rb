require 'spec_helper'
require 'guard/rails-assets'

describe Guard::RailsAssets do
  let(:options) { {} }
  let(:rails_thread) { mock(Guard::RailsAssets::RailsThread) }
  subject { Guard::RailsAssets.new(['watchers'], options) }

  before do
    Guard::RailsAssets::RailsThread.stub(:new => rails_thread)
    rails_thread.stub(:compile_assets => true, :restart_rails => true)
  end

  describe '#start' do
    it_behaves_like 'guard command', :command => :start,         :run => true
  end

  describe '#reload' do
    it_behaves_like 'guard command', :command => :reload,        :run => false
  end

  describe '#run_all' do
    it_behaves_like 'guard command', :command => :run_all,       :run => false
  end

  describe '#run_on_change' do
    it_behaves_like 'guard command', :command => :run_on_change, :run => true
  end

  describe 'run options' do
    it 'should allow array of symbols' do
      guard = Guard::RailsAssets.new(['watchers'], :run_on => [:start, :change])
      guard.run_for?(:start).should be_true
      guard.run_for?(:reload).should be_false
    end

    it 'should allow symbol' do
      guard = Guard::RailsAssets.new(['watchers'], :run_on => :start)
      guard.run_for?(:start).should be_true
      guard.run_for?(:reload).should be_false
    end
  end

  describe 'asset compilation using CLI' do
    def stub_system_with result
      rails_thread.should_receive(:compile_assets).and_return result
    end

    it 'should notify on success' do
      stub_system_with true
      Guard::Notifier.should_receive(:notify).with('Assets compiled')
      subject.compile_assets
    end

    it 'should notify on failure' do
      stub_system_with false
      subject.should_not_receive(:`) # don't obtain tree
      Guard::Notifier.should_receive(:notify).with('see the details in the terminal', :title => "Can't compile assets", :image => :failed)
      subject.compile_assets
    end
  end
end
