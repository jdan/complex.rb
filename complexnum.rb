class ComplexNum
  attr_reader :real, :imag

  def initialize(a=0, b=0)
    @real = a
    @imag = b
  end

  def conjugate
    ComplexNum.new @real, -@imag
  end
  alias :conj :conjugate

  def magnitude
    Math.sqrt(@real**2 + @imag**2)
  end
  alias :abs :magnitude

  # When we coerce types (i.e. 2 * ComplexNum[]), we simply need to switch
  # the operands and use the normal overloaded methods
  def coerce(other)
    return CoercedComplexNum.new(@real, @imag), other
  end

  def +(other)
    real = @real + other.real
    imag = @imag + other.imag

    ComplexNum.new real, imag
  end

  def -(other)
    self + (-other)
  end

  # Unary -
  def -@
    self * -1
  end

  def *(other)
    real = @real * other.real - @imag * other.imag
    imag = @real * other.imag + @imag * other.real

    ComplexNum.new real, imag
  end

  def **(n)
    if n < 0
      1 / (self ** -n)
    elsif n == 0
      1
    else
      # Divide and conquer
      halfpow = (self ** (n/2))

      slice = halfpow * halfpow
      slice *= self if n % 2 == 1

      slice
    end
  end

  def /(other)
    dividend = (other * other.conj).real
    self * (other.conj) * (1.0 / dividend)
  end

  def to_s
    if @real == 0
      # No need to show "1i", just "i"
      if @imag == 1
        "i"
      elsif @imag == -1
        "-i"
      else
        "#{@imag}i"
      end
    elsif @imag == 0
      "#{@real}"
    elsif @imag < 0
      # No need to show "1i", just "i"
      "#{@real} - #{@imag == -1 ? "" : -@imag}i"
    else
      # No need to show "1i", just "i"
      "#{@real} + #{@imag == 1 ? "" : @imag}i"
    end
  end
  alias :inspect :to_s

end

# Subclass to help with type coercion with non-commutative operations.
#
# This class simply overwrites the normal `-` and `/` methods to work in
# reverse.
class CoercedComplexNum < ComplexNum
  # other - self
  def -(other)
    ComplexNum.new(other) - self
  end

  # other / self
  def /(other)
    ComplexNum.new(other) / self
  end
end
