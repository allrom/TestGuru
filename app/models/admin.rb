class Admin < User
  
  validates :identity_sname, presence: true
end
