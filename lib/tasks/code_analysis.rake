task code_analysis: :environment  do
  ['rubocop', 'reek'].each do |task|
    sh task
  end
end
