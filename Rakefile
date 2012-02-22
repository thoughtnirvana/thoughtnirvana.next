require "#{File.dirname(__FILE__)}/rb/main"

task :compile do |t|
  output_dir = '_site'
  if File.directory?(output_dir)
    system "rm -rf #{output_dir}/*"
  else
    system "mkdir #{output_dir}"
  end
  gen_site(pretty: false, prod: true)
  system "cp -r css img js *.html #{output_dir}"
end
