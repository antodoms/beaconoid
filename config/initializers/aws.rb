  # Aws.config.update({
  #   region: 'us-east-1',
  #   endpoint: 'http://0.0.0.0:8000/',
  #   force_path_style: true,
  #   credentials: Aws::Credentials.new('accessKey1', 'verySecreyKey1'),
  # })

  #  Aws.config.update({
  #   region: 'us-west-2',
  #   credentials: Aws::Credentials.new(ENV['ACCESS_KEY_ID'], ENV['SECRET_ACCESS_KEY']),
  # })

Aws.config.update({
    region: ENV['AWS_REGION'],
    endpoint: ENV['AWS_ENDPOINT'],
    force_path_style: true,
    credentials: Aws::Credentials.new(ENV['ACCESS_KEY_ID'], ENV['SECRET_ACCESS_KEY']),
  })