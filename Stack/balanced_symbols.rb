require 'byebug'

module Stack
  module UtilMethods

    # Insert into stack if new parenthesis.
    # If new parenthesis is oppt of stack.top ? then pop from stack.
    # At end just if stack is empty ( balanced ) or not (Not balanced).
    def self.is_balanced?(expression:)
      stack = []
      closing_symbols = { '(' => ')', '{' => '}', '[' => ']' }

      expression.each_char do |char|
        if closing_symbols.key?(char)
          stack.push(char)
        elsif closing_symbols[stack.last] == char
          stack.pop
        end
      end
      return stack.empty?
    end

    def self.xyz
    end
  end
end

print Stack::UtilMethods.is_balanced?(expression: 'A+[C-D]')
