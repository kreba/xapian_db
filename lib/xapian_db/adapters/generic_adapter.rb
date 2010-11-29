# encoding: utf-8

# The generic adapter is a universal adapater that can be used for any
# ruby class. To use the generic adapter (which is the default),
# configure the expression that generates a unique key from your objects 
# using the method 'unique_key'.
module XapianDb
  module Adapters
     
    class GenericAdapter

      class << self
        
        # Define the unique key expression
        def unique_key(&block)
          @unique_key_block = block
        end
        
        # Implement the helper methods
        def add_helper_methods_to(klass)
          expression = @unique_key_block
          klass.instance_eval do
            define_method(:xapian_id) do
              instance_eval &expression
            end
          end
        end
        
      end

    end
     
  end
   
end