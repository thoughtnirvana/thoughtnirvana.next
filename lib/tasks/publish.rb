require 'aws-sdk-s3'
require 'json'
require 'digest/md5'
require 'byebug'

creds = JSON.load(File.read('credentials.json'))
s3 = Aws::S3::Client.new(credentials: Aws::Credentials.new(creds['accessKey'], creds['secretKey']),
                         region: creds['region'])

namespace :static do
  desc 'Publish the generated files'
  task publish: [:build] do
    s3_bucket = Environment.config.s3_bucket
    current_etag =  s3.list_objects({
      bucket: s3_bucket
    })
    .contents
    .reduce({}) do |key_and_etag, current|
      key_and_etag[current.key] = current.etag
      key_and_etag
    end

    static_build_dir = Environment.config.static_build_dir

    Dir["#{static_build_dir}/**/*"].each do |file|
      next unless File.file? file

      upload_contents = File.read(file)
      upload_etag = Digest::MD5.hexdigest(upload_contents)
      remote_file = file.gsub("#{static_build_dir}/", '')

      next if "\"#{upload_etag}\"" == current_etag[remote_file]

      Environment.logger.info("Uploading #{file} to s3 as #{remote_file}")
      s3.put_object({
        bucket: s3_bucket,
        key: remote_file,
        body: File.read(file),
        acl: 'public-read'
      })
    end
  end
end
