require 'spec_helper'

describe Guard::RailsAssets::CliRunner do

  subject { Guard::RailsAssets::CliRunner.new({}) }

  it 'should run the command' do
    subject.stub(:system)
    subject.should_receive(:system).with("bundle exec rake assets:clean assets:precompile")
    subject.compile_assets
  end
end
