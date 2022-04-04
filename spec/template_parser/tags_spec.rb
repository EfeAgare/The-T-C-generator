require_relative '../../lib/template_parser/input_file'
require_relative '../../lib/template_parser/tags'

RSpec.describe 'TemplateParser::Tags' do

  let(:header) { ["A T&C Document\n"] }
  let(:body) { ["\n", "This document is made of plaintext. \n", "Is made of [CLAUSE-3].\n", "Is made of [CLAUSE-4].\n", "Is made of [SECTION-1].\n", "\n"]}
  let(:new_body) { ["\n", "This document is made of plaintext. \n", "Is made of And dies.\n", 
       "Is made of The white horse is white.\n",
       "Is made of The quick brown fox;jumps over the lazy dog.\n",
       "\n"] }
  let(:footer) { ["Your legals."] }
  let(:rows) { header + body + footer }
  let(:file_path) { "test.txt" }
  let!(:txt) do
    File.open('test.txt', 'w') {|f| rows.each { |row| f << row } }
  end

  let(:input_file) { TemplateParser::InputFile.read(file_path) }

  after(:each) { File.delete(file_path) }

  subject { TemplateParser::Tags.new(input_file[1..-2]) }

  context 'When TemplateParser::Tags is instantiated and read is called' do
    it 'stores the new parse tags valuse in the attr_reader variables' do
      input_file
      subject.process

      expect(subject.tags).to eq new_body
    end
  end
end
