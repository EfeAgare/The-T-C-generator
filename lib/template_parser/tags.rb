require 'json'

module TemplateParser
  class Tags
    attr_reader :tags

    def initialize(tags)
      @tags = tags
    end

    def process
      add_clause_tags_to_template
      add_section_tags_to_template
    end

    private

    def add_clause_tags_to_template
      read_clause_tags.each do |clause|
        @tags.each do |tag|
          if tag.include?("[CLAUSE-#{clause["id"]}]")
            tag.sub!("[CLAUSE-#{clause["id"]}]", "#{clause["text"]}")
          end
        end
      end
    end

    def add_section_tags_to_template
      clause_tag_text = ""

      read_section_tags.each do |section|
        ids = section["clauses_ids"]

        ## loop through each clause_ids to 
        ## get the text associated with the clause_id
        ids.each_with_index do |id, index|
          read_clause_tags.each do |clause|
            clause_tag_text += clause["text"]+"#{index < ids.length-1 ? ";" : "" }"  if clause["id"] == id
          end
        end

        ## assigned the text to the template to display the 
        ## exact clause text associated with the section id
        @tags.each do |tag|
          if tag.include?("[SECTION-#{section["id"]}]")
            tag.sub!("[SECTION-#{section["id"]}]", clause_tag_text)
          end
        end

        clause_tag_text = ""
      end
    end

    def read_section_tags
      read_section_tags ||= JSON.parse(File.read("data/sections.json"))
    end

    def read_clause_tags
      read_clause_tags ||= JSON.parse(File.read("data/clauses.json"))
    end
  end
end
