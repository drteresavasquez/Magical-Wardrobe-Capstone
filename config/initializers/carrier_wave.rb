
if Rails.env.production?
    CarrierWave.configure do |config|
      config.fog_credentials = {
        # Configuration for Amazon S3
        :provider              => 'AWS',
        :aws_access_key_id     => ENV['AKIAIHKUEX77Y6KXAH4Q'],
        :aws_secret_access_key => ENV['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']
      }
      config.fog_directory     =  ENV['magical_wardrobe']
    end
  end