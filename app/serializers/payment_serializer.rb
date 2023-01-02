class PaymentSerializer < ActiveModel::Serializer
  attributes :id, :phone, :total
end
