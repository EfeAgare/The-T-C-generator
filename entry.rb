require_relative './lib/template_parser/input_file'

file = "data/template.txt"

file_lines = TemplateParser::InputFile.read(file)

# file_lines.first  ## act as file header
# file_lines[1..-2] ## act as file body
# file_lines.last   ## act as file footer

puts file_lines[1..-2]
