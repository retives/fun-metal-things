class Order < ApplicationRecord
    belongs_to :user [cite: 265]
    has_many :order_items, dependent :detroy
    has_one :payment, dependent :destroy [cite 186]

    enum status: {pending:'pending', processing:'processing', shipped:'shipped', selivered:'delivered'}
    

end
