require 'spec_helper'

describe Guard::RailsAssets::RailsRunner do
  
  describe ".compile_assets" do
    
    let(:asset_pipeline) { Guard::RailsAssets::RailsRunner::AssetPipeline }
    
    before do
      described_class.class_eval do
        def boot_rails
        end
      end
    end
    
    context "successful compile" do
      before do
        asset_pipeline.stub(:clean)
        asset_pipeline.stub(:precompile)
      end
      
      it "clean's the assets" do
        asset_pipeline.should_receive(:clean)
        subject.compile_assets
      end
      
      it "runs the compiler" do
        asset_pipeline.should_receive(:precompile)
        subject.compile_assets
      end
      
      it "returns true" do
        subject.compile_assets.should be_true
      end
    end
    
    context "with a compilation error" do
      
      before do
        asset_pipeline.stub(:clean)
        asset_pipeline.should_receive(:precompile).and_raise(StandardError)
        @output = capture(:stdout) do
          @result = subject.compile_assets
        end
      end
      
      it "outputs the error" do
        @output.should include("An error occurred")
      end
      
      it "returns false" do
        @result.should be_false
      end
      
      context "on next successful compile" do
        
        it "works" do
          asset_pipeline.should_receive(:clean)
          asset_pipeline.should_receive(:precompile)
          subject.compile_assets.should be_true
        end
        
      end
      
    end
    
  end
  
end
