require_relative './lib/template_parser/input_file'
require_relative './lib/template_parser/tags'
require_relative './lib/print_terms_and_conditions'

file = "data/template.txt"

file_lines = TemplateParser::InputFile.read(file)

# file_lines.first  ## act as file header
# file_lines[1..-2] ## act as file body that contains tags
# file_lines.last   ## act as file footer

tags = TemplateParser::Tags.new(file_lines[1..-2])

tags.process

# this create a T&C.txt file
PrintTermsAndConditions.process(file_lines.first, tags.sections_and_clauses, file_lines.last)
