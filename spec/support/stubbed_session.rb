class StubbedSession
  def initialize
    @closed = false
  end

  def close
    @closed = true
  end

  def closed?
    @closed
  end

  def exec! command, &block
    yield ['foo', :stdout, "woop woop"]
  end
end