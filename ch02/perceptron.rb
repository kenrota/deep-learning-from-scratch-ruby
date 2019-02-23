require 'numo/narray'

def and_gate(x1, x2)
  x = Numo::DFloat[x1, x2]
  w = Numo::DFloat[0.5, 0.5]
  b = -0.7

  tmp = (x * w).sum + b
  tmp <= 0 ? 0 : 1
end

p and_gate(0, 0)
p and_gate(0, 1)
p and_gate(1, 0)
p and_gate(1, 1)

def nand_gate(x1, x2)
  x = Numo::DFloat[x1, x2]
  w = Numo::DFloat[-0.5, -0.5]
  b = 0.7

  tmp = (x * w).sum + b
  tmp <= 0 ? 0 : 1
end

p nand_gate(0, 0)
p nand_gate(0, 1)
p nand_gate(1, 0)
p nand_gate(1, 1)

def or_gate(x1, x2)
  x = Numo::DFloat[x1, x2]
  w = Numo::DFloat[0.5, 0.5]
  b = -0.2

  tmp = (x * w).sum + b
  tmp <= 0 ? 0 : 1
end

p or_gate(0, 0)
p or_gate(0, 1)
p or_gate(1, 0)
p or_gate(1, 1)

def xor_gate(x1, x2)
  s1 = nand_gate(x1, x2)
  s2 = or_gate(x1, x2)
  and_gate(s1, s2)
end

p xor_gate(0, 0)
p xor_gate(0, 1)
p xor_gate(1, 0)
p xor_gate(1, 1)
