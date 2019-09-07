defmodule Complex do

  defstruct real: 0, imaginary: 0

  def from(n) do
    %Complex{real: n, imaginary: 0}
  end

  def cartesian(x, y) do
    %Complex{real: x, imaginary: y}
  end

  def polar(r, theta) do
    %Complex{real: r * :math.cos(theta), imaginary: r * :math.sin(theta)}
  end

  def conjugate(%Complex{real: r, imaginary: i}) do
    %Complex{real: r, imaginary: -i}
  end

  def add(%Complex{real: r1, imaginary: i1}, %Complex{real: r2, imaginary: i2}) do
    %Complex{real: r1 + r2, imaginary: i1 + i2}
  end

  def multiply(%Complex{real: r1, imaginary: i1}, %Complex{real: r2, imaginary: i2}) do
    %Complex{real: r1 * r2 - i1 * i2, imaginary: r1 * i2 + r2 * i1}
  end

  def divide(%Complex{real: r1, imaginary: i1}, %Complex{real: r2, imaginary: i2}) do
    denominator = :math.pow(r2, 2) + :math.pow(i2, 2)

    %Complex{
      real: (r1 * r2 + i1 * i2)  / denominator,
      imaginary: (r2 * i1 - r1 * i2) / denominator
    }
  end

  def magnitude(%Complex{real: r, imaginary: i}) do
    :math.sqrt(:math.pow(r, 2) + :math.pow(i, 2))
  end

  def phase(%Complex{real: r, imaginary: i}) do
    :math.atan2(i, r)
  end

  def to_string(%Complex{real: r, imaginary: i}) when i == 0, do: "#{r}"
  def to_string(%Complex{real: r, imaginary: i}) when i > 0, do: "#{r} + #{i}i"
  def to_string(%Complex{real: r, imaginary: i}) when i < 0, do: "#{r} - #{-i}i"

  def polar_form(%Complex{real: r, imaginary: i} = complex) do
    "#{magnitude(complex)} * e^#{phase(complex)}i"
  end
end

defimpl Inspect, for: Complex do
  def inspect(complex, _opts) do
    Complex.to_string(complex)
  end
end

defimpl String.Chars, for: Complex do
  def to_string(complex) do
    Complex.to_string(complex)
  end
end

defmodule Example do
  def run do
    z = Complex.cartesian(1, 3)
    w = Complex.cartesian(3, -2)

    solution1 = Complex.add(Complex.conjugate(z), Complex.conjugate(w))
    solution2 = Complex.multiply(z, w)
    solution3 = Complex.divide(Complex.from(1), z)

    IO.puts solution1
    IO.puts solution2
    IO.puts solution3

    IO.puts "|z| = #{Complex.magnitude(z)}"
    IO.puts "|w| = #{Complex.magnitude(w)}"
    IO.puts "tht = #{Complex.phase(solution3)}"

    IO.puts Complex.from(1)

    IO.puts Complex.polar_form(Complex.cartesian(0, -8))
    IO.puts Complex.polar_form(Complex.cartesian(-2, 0))
    IO.puts Complex.polar_form(Complex.cartesian(4, 4))
    IO.puts Complex.polar_form(Complex.cartesian(-6, -6*:math.sqrt(3)))

    IO.puts Complex.polar_form(Complex.polar(2, :math.pi))
  end
end

Example.run
