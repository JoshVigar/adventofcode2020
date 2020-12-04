# frozen_string_literal: true

def delta
  t1 = Time.now
  yield
  t2 = Time.now
  p t2 - t1
end
