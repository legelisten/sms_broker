task code_analysis: :environment  do
  ['rubocop -R'].each do |task|
    sh task
  end
end
