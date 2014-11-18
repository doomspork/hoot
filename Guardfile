guard :spork do
  watch('Gemfile.lock')
  watch('spec/spec_helper.rb') { :rspec }
end

guard :rspec, cmd: 'rspec' do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/hoot/(.+)\.(rb|treetop)$}) { |m| "spec/hoot/#{m[1]}_spec.rb" }
  watch(%r{^spec/support/(.+)\.rb$}) { 'rspec' }
end
