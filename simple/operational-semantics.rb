# Operational semantics for (1 * 2) + (3 * 4)
# p.23
#

class Number < Struct.new(:value)
  def to_s
    value.to_s
  end

  def inspect
    "<< #{self} >>"
  end

  def reducible?
    false
  end
end

class Add < Struct.new(:left, :right)
  def to_s
    "#{left} + #{right}"
  end

  def inspect
    "<< #{self} >>"
  end

  def reducible?
    true
  end

  # This follows a left-to-right reduction strategy
  def reduce
    if left.reducible?
      Add.new(left.reduce, right)
    elsif right.reducible?
      Add.new(left, right.reduce)
    else
      Number.new(left.value + right.value)
    end
  end
end

class Multiply < Struct.new(:left, :right)
  def to_s
    "#{left} * #{right}"
  end

  def inspect
    "<< #{self} >>"
  end

  def reducible?
    true
  end

  def reduce
    if left.reducible?
      Multiply.new(left.reduce, right)
    elsif right.reducible?
      Multiply.new(left, right.reduce)
    else
      Number.new(left.value * right.value)
    end
  end
end

# AST

ast = Add.new(
  Multiply.new(Number.new(1), Number.new(2)),
  Multiply.new(Number.new(3), Number.new(4))
)

# Output

puts ast.inspect

puts "Reducible?: #{ast.reducible?}"
puts ast = ast.reduce
puts "Reducible?: #{ast.reducible?}"
puts ast = ast.reduce
puts "Reducible?: #{ast.reducible?}"
puts ast = ast.reduce
puts "Reducible?: #{ast.reducible?}"
puts ast = ast.reduce



