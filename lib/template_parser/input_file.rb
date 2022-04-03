require_relative '../../helpers'

module TemplateParser
  class InputFile
    def self.read(file)
      File.foreach(file).to_a
    end
  end
end
