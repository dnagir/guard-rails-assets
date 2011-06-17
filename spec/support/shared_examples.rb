shared_examples_for "guard command" do |info|

  def set_run_on_option info
    # run_on_change -> change
    # run_all -> all
    run_option = info[:command].to_s.match(/(.*_)?(\w+)/)[2].to_sym
    options[:run_on] = [run_option]
  end

  it "should execute #{info[:command]} when said so" do
    set_run_on_option info
    subject.should_receive(:compile_assets)
    subject.send(info[:command])
  end
  it "should not execute #{info[:command]} when disabled" do
    options[:run_on] = [:something_other]
    subject.should_not_receive(:compile_assets)
    subject.send(info[:command])
  end

  it "should #{info[:run] ? '' : 'not '}execute #{info[:command]} by default" do
    options[:run_on] = nil
    if info[:run]
      subject.should_receive(:compile_assets)
    else
      subject.should_not_receive(:compile_assets)
    end
    subject.send(info[:command])
  end

end
