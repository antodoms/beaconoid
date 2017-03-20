class Store
  include Mongoid::Document
  field :name, type: String
  field :code, type: String
end