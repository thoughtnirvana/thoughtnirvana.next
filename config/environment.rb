require 'ostruct'
$LOAD_PATH.unshift Dir.pwd

class Environment
  def self.config
    config = {
      static_build_dir: '_build'
    }
    OpenStruct.new config
  end
end
