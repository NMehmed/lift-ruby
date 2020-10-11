class Cart
  def calculate_cart_total(cart_contents)
    $different_books_count = get_different_books_count(cart_contents)
    $cost = 0
    
    while $different_books_count.size > 0 do 
      $collection_price = get_collection_price($different_books_count.size)
      
      $collection_count = get_collection_count($different_books_count)
      
      $cost = $cost + ($collection_count * $collection_price)
      
      remove_calculated_collections($different_books_count, $collection_count)
    end
    
    return $cost
  end
  
  def get_different_books_count(cart_contents)
    $different_books_count = Hash.new()
  
    cart_contents.each { |purchase|
      if $different_books_count.has_key?(purchase) 
        $different_books_count[purchase] += 1
      else
        $different_books_count[purchase] = 1
      end
    }
    
    return $different_books_count
  end
  
  def get_collection_price(collection_size)
    $price = 10
    
    if collection_size == 4
      $price = 32
    elsif collection_size == 3
      $price = 27
    elsif collection_size == 2
      $price = 19
    end
    
    return $price
  end
  
  def get_collection_count(different_books_count)
    return different_books_count.values().sort[0]
  end
  
  def remove_calculated_collections(different_books_count, calculated_colllections)
    different_books_count.each { |key, value|
      different_books_count[key] = value - calculated_colllections
        
      if different_books_count[key] == 0
        different_books_count.delete(key)
      end
    }
  end
end
