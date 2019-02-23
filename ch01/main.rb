require 'numo/narray'
require "numo/gnuplot"

def math
  x = Numo::DFloat[1, 2, 3]
  y = Numo::DFloat[2, 4, 6]
  p x + y
  p x - y
  p x * y
  p x / y
  p x / 2.0
end

def n_dimension
  a = Numo::DFloat[[1, 2], [3, 4]]
  p a
  p a.shape
  p Numo::NArray.array_type(a)

  b = Numo::DFloat[[3, 0], [0, 6]]
  p a + b
  p a * b
end

def broadcast
  a = Numo::DFloat[[1, 2], [3, 4]]
  b = Numo::DFloat[[10, 20]]
  p a * b
end

def access_element
  x = Numo::DFloat[[51, 55], [14, 19], [0, 4]]
  p x[0, true]
  p x[0, 1]
  x = x.flatten
  p x
  p x[Numo::DFloat[0, 2, 4]]
  p x > 15
  p x[x > 15]
end

def plot
  x = Numo::DFloat[0..60]/10
  y = Numo::NMath.sin(x)

  Numo.gnuplot do
    set terminal:"png"
    set output:"sin.png"
    set title:"X-Y data plot in Numo::NArray"
    plot x,y, w:'lines', t:'sin(x)'
  end
end

#math
#n_dimension
#broadcast
#access_element
plot
