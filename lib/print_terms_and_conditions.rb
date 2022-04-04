class PrintTermsAndConditions
  def self.process(header, body, footer)
    template_array = [header] + body + [footer]

    File.open('T&C.txt', 'w') {|f| template_array.each { |line| f << line } }
  end
end
