CarrierWave.configure do |config|
  config.cache_storage = :file
  config.storage = :cloudinary
  config.cloudinary_credentials = {
    cloud_name: Rails.application.credentials[:cloudinary_cloud_name],
    api_key:    Rails.application.credentials[:cloudinary_api_key],
    api_secret: Rails.application.credentials[:cloudinary_api_secret],
  }
end
