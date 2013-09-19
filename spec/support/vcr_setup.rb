VCR.configure do |c|
  c.cassette_library_dir = 'spec/vcr'
  # Your HTTP request service. You can also use fakeweb, webmock, and more
  c.hook_into :webmock

  c.filter_sensitive_data('<PASSWORD>') { '********' }
end
