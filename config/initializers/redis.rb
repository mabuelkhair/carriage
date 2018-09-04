# $redis = Redis::Namespace.new("carriage", :redis => Redis.new)
$redis = Redis.new(host: 'redis', port: 6379)