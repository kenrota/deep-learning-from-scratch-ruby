require 'zlib'
require 'json'
require 'numo/narray'

class MnistTestImage
  attr_reader :magic_number, :num_images, :num_rows, :num_columns, :num_pixels
  attr_reader :images

  def initialize()
    @images = []
    load_images()
  end

  def load_images()
    Zlib::GzipReader.open('t10k-images-idx3-ubyte.gz') do |f|
      @magic_number = f.read(4).unpack('N*')[0]
      @num_images   = f.read(4).unpack('N*')[0]
      @num_rows     = f.read(4).unpack('N*')[0]
      @num_columns  = f.read(4).unpack('N*')[0]
      @num_pixels   = @num_rows * @num_columns

      @num_images.times do
        pixels = f.read(@num_pixels).unpack('C*')
        normalized = pixels.map { |p| p / 255.0 }
        @images.push(Numo::DFloat[*normalized])
      end
    end
  end
end

class MnistTestLabel
  attr_reader :magic_number, :num_labels
  attr_reader :labels

  def initialize()
    @labels = []
    load_labels()
  end

  def load_labels()
    Zlib::GzipReader.open('t10k-labels-idx1-ubyte.gz') do |f|
      @magic_number = f.read(4).unpack('N*')[0]
      @num_labels   = f.read(4).unpack('N*')[0]

      @num_labels.times do
        @labels.push(f.read(1).unpack('C*')[0])
      end
    end
  end
end

def initialize_network
  File.open('sample_weight.json') do |data|
    JSON.load(data)
  end
end

def sigmoid(x)
  1 / (1 + Numo::DFloat::Math.exp(-x))
end

def softmax(a)
  c = a.max
  exp_a = Numo::DFloat::Math.exp(a - c)
  sum_exp_a = exp_a.sum
  exp_a / sum_exp_a
end

def predict(network, x)
  w1 = Numo::DFloat[*network['W1']].reshape(784, 50)
  w2 = Numo::DFloat[*network['W2']].reshape(50, 100)
  w3 = Numo::DFloat[*network['W3']].reshape(100, 10)
  b1 = Numo::DFloat[*network['b1']]
  b2 = Numo::DFloat[*network['b2']]
  b3 = Numo::DFloat[*network['b3']]

  a1 = x.dot(w1) + b1
  z1 = sigmoid(a1)
  a2 = z1.dot(w2) + b2
  z2 = sigmoid(a2)
  a3 = z2.dot(w3) + b3
  softmax(a3)
end

def run
  test_image = MnistTestImage.new
  test_label = MnistTestLabel.new
  network = initialize_network

  accuracy_cnt = 0
  (0..test_image.num_images-1).each do |i|
    y = predict(network, test_image.images[i])
    p = y.max_index
    if p == test_label.labels[i]
      accuracy_cnt += 1
    end
  end

  puts "Accuracy: #{accuracy_cnt / test_image.num_images.to_f}"
end

run
