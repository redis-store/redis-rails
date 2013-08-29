require 'test_helper'

describe Redis::Rails::VERSION do
  it 'returns current version' do
    Redis::Rails::VERSION.must_equal '3.2.4'
  end
end
