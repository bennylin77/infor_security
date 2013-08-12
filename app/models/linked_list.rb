class Node

    attr_accessor :name, :value, :next_node

    def initialize(nam,val,next_in_line)
		@name = nam
        @value = val
        @next_nodex = next_in_line
    end 
end

class LinkedList

    def initialize(nam,val)
        # Initialize a new node at the head
        @head = Node.new(nam,val,nil)
    end
    
    def add(nam,value)
        # Traverse to the end of the list
        # And insert a new node over there with the specified value
        current = @head
		
		if current.name.eql? nam
			current.value+=value
		else		
			while current.next_node != nil
				current = current.next_node
				if current.name.eql? nam
					current.value+=value
					return nil
				end
			end  
			current.next_node = Node.new(nam,value,nil)			
		end
       
        self    
    end

	def re_list
		@head
	end

end
