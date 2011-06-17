shared_examples_for "guard command" do |options|

  it "should execute #{options[:command]} when said so"
  it "should not execute #{options[:command]} when disabled"

  it "should #{options[:run] ? '' : 'not '}execute #{options[:command]} by default"
  it "should execute built-in helper"

end
