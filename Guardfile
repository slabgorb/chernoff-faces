guard 'rspec', version:2, cli:"--drb -c -fd --drb-port 8988", rspec_env:{ 'RAILS_ENV' => 'test'} do
  watch(%r{^spec/.+5000_spec\.rb$})
  watch('spec/spec_helper.rb')  { "spec" }
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})                           { |m| "spec/#{m[1]}_spec.rb" }
end

guard 'bundler' do
  watch('Gemfile')
end

