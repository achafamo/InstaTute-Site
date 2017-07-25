# config/initializers/carrierwave.rb
require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

if Rails.env.test? or Rails.env.development?
  CarrierWave.configure do |config|
    config.storage = :file
    config.root = "#{Rails.root}/tmp"
    config.cache_dir = "#{Rails.root}/tmp/images"
    config.fog_directory = 'socify'
  end
else
  CarrierWave.configure do |config|
    config.storage = :fog     
	config.fog_provider = 'fog/aws'     
    config.fog_credentials = {
      :provider => 'AWS',
      :aws_access_key_id => ENV['S3_ACCESS_KEY'],
      :aws_secret_access_key => ENV['S3_SECRET_KEY'],
      :region => ENV['S3_REGION']
    }
    
    config.fog_directory = ENV['S3_BUCKET_NAME']
    config.asset_host = "#{ENV['S3_ASSET_URL']}/#{ENV['S3_BUCKET_NAME']}"
  end
end
