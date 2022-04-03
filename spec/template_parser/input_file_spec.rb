require_relative '../../lib/template_parser/input_file'

RSpec.describe 'TemplateParser::InpuFile' do
  
  let(:header) { ["A T&C Document\n"] }
  let(:body) { ["\n", "This document is made of plaintext. \n", "Is made of [CLAUSE-3].\n", "Is made of [CLAUSE-4].\n", "Is made of [SECTION-1].\n", "\n"]}
  let(:footer) { ["Your legals."] }
  let(:rows) { header + body + footer }
  let(:file_path) { "test.txt" }
  let!(:txt) do
    File.open('test.txt', 'w') {|f| rows.each { |row| f << row } }
  end

  after(:each) { File.delete(file_path) }

  subject { TemplateParser::InputFile.read(file_path) }

  context 'When TemplateParser::InputFile.read is called' do
    it 'stores the file content in the assigned variables' do
      subject

      expect(subject.first).to eq header[0]
      expect(subject.last).to eq footer[0]
      expect(subject[1..-2]).to eq body
    end
  end
end
  