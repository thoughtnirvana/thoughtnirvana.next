require 'fileutils'


namespace :static do
  desc 'Generates static html from the controllers and templates'
  task :generate_html do |t|
    build_dir = Environment.config.static_build_dir 
    $LOAD_PATH.unshift Dir.pwd
    Dir['app/controllers/**/*.rb'].each do |controller|
      file_name = File.basename controller
      file_name_sans_ext = file_name[0...-3]
      output_dir = file_name == 'index.rb' ? build_dir : File.join(build_dir, file_name_sans_ext)
      output_file = File.join(output_dir, 'index.html')

      next if file_name == 'base.rb'

      require controller
      class_name = file_name_sans_ext.capitalize
      output_file_contents = Module.const_get(class_name).new.render

      next if File.exist?(output_file) && output_file_contents == File.read(output_file)
      Environment.logger.info("Generating #{output_file} from #{controller}")

      FileUtils.mkdir_p(output_dir) unless File.exist?(output_dir)
      File.open(output_file, 'w') {|f| f.write output_file_contents}
    end
  end
end