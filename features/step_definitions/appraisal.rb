When /^I run `([^"]+)` with a clean environment$/ do |command|
  step <<~STEP
    I successfully run `ruby -e 'system({"BUNDLE_GEMFILE" => nil, "DISABLE_SPRING" => "true"}, "#{command}")'`
  STEP
end
