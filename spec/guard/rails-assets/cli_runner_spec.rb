require 'spec_helper'

describe Guard::RailsAssets::CliRunner do

  it 'should run the command' do
    subject.stub(:system)
    subject.should_receive(:system).with("bundle exec rake assets:clean assets:precompile RAILS_ENV=test")
    subject.compile_assets
  end

  context 'with production environment' do
    subject { Guard::RailsAssets::CliRunner.new(:rails_env => :production) }
    it 'should run the command' do
      subject.stub(:system)
      subject.should_receive(:system).with("bundle exec rake assets:clean assets:precompile RAILS_ENV=production")
      subject.compile_assets
    end
  end
end
