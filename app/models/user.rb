class User < ApplicationRecord
  enum :status, {
    unknown: 0,
    warn: 2,
    alert: 3,
    approved: 4,
  }
end
