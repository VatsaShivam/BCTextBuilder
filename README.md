# 📘 TextBuilder & File Generation in Business Central (AL)
# Table of Contents
  1. TextBuilder Overview
  2. Common Methods
  3. Generating Files
     - CSV
     - JSON
     - XML
     - Email body
  4. Implementation Tips & Best Practices

# TextBuilder Overview
  TextBuilder is a high-performance, mutable string buffer—ideal for heavy string manipulation without the overhead     of repeated allocations
    - Reference type, unlike Text, making it efficient in loops and concatenations.
    - 1-based indexing, optimized for sequential Append, Insert, Remove, and Replace operations

# Common Methods
  - Append, AppendLine
  - Insert(pos, text) 
  - Replace(old,new[,start,len])
  - Remove(pos,len)
  - Length(), MaxCapacity()
  - ToText([start,len])

