require "#{File.dirname(__FILE__)}/rb/main"
$cur_dir = File.dirname(__FILE__)

task :compile do |t|
  output_dir = '_site'
  if File.directory?(output_dir)
    system "rm -rf #{output_dir}/*"
  else
    system "mkdir #{output_dir}"
  end
  gen_site(pretty: false, prod: true)
  system "cp -r rb/css rb/img rb/js rb/*.html #{output_dir}"
end

task :dev_server do |t|
  system "sudo service nginx stop"
  system"sudo nginx -c #{$cur_dir}/nginx.dev.conf"
  puts "nginx restarted"
end

task :server do |t|
  system "sudo service nginx stop"
  system"sudo nginx -c #{$cur_dir}/nginx.conf"
  puts "nginx restarted"
end
