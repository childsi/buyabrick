class String
  def ^(other)
    if other.empty?
      self
    else
      a1 = self.unpack("c*")
      a2 = other.unpack("c*")

      a2 *= a1.length/a2.length + 1

      a1.zip(a2).collect{|c1,c2| c1^c2}.pack("c*")
    end
  end
end
