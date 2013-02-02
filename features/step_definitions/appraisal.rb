When /^I run `([^"]+)` with a clean environment$/ do |command|
  step %{I successfully run `ruby -e 'system({"BUNDLE_GEMFILE" => nil}, "#{command}")'`}
end

# system({'BUNDLE_GEMFILE' => nil}, "cd tmp/aruba/testapp && #{command} && cd -")
