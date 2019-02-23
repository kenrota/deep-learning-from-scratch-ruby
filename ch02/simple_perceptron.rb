require 'numo/narray'

def and_gate(x1, x2)
  w1 = 0.5
  w2 = 0.5
  theata = 0.7
  tmp = x1 * w1 + x2 * w2
  tmp <= theata ? 0 : 1
end

p and_gate(0, 0)
p and_gate(0, 1)
p and_gate(1, 0)
p and_gate(1, 1)
