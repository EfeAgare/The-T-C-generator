## T&C generator
The T&C generator is a software which given: 

 - A template 
 - A dataset

transforms the template into a Document expanding the template tags into their representation using the dataset. 

## Description

### Template
Is a text made of:
  - Plaintext Tags
  - Tags

### Tags
The tags supported are:
  - Clauses: [CLAUSE-#{ID}]
  - Sections: A group of clauses, represented with [SECTION-#{ID}]

### Example
Given the following template:

```
A T&C Document

This document is made of plaintext.
Is made of [CLAUSE-3].
Is made of [CLAUSE-4].
Is made of [SECTION-1].

Your legals.
```

And the following dataset: 

clauses:
```
[
  { "id": 1, "text": 'The quick brown fox' },
  { "id": 2, "text": 'jumps over the lazy dog' },
  { "id": 3, "text": 'And dies' },
  { "id": 4, "text": 'The white horse is white' }
]
```

sections:

```
[
  { "id": 1, "clauses_ids": [1, 2] }
]

```
Creates the following T&C document:

```
A T&C Document

This document is made of plaintext.
Is made of And dies.
Is made of The white horse is white.
Is made of The quick brown fox;jumps over the lazy dog.

Your legals.
```

## Technologies
  * Ruby
  * Git
  * Rspec


## Design decisions
 - In reading template.txt file store the files in a variable and access individual value
   grouping file lines into header, body and header, since it still a smaller file size
    instead of 
   
   ```
    File.foreach(file) do |row|
      next @header << row if row.include?("A T&C Document")
      next @footer << row if row.include?("Your legals.")
      @body << row
    end
    ```

    because when `A T&C Document` value is chnaged the code breaks


### how much time you took

### what you would have done if given more time

 - Find a better way to read template file and store in variable
