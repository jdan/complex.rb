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

  # When we coerce types (i.e. 2 * ComplexNum[]), we simply need to switch
  # the operands and use the normal overloaded methods
  def coerce(other)
    return self, other
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

  def /(other)
    dividend = (other * other.conj).real
    self * (other.conj) * (1.0 / dividend)
  end

  def to_s
    "#{@real} + #{@imag}i"
  end
  alias :inspect :to_s

end
