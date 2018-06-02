module Webhooks
	class ChargeSucceeded
		def call(event)
			charge = event.data.object
			user = User.find_by(cus: charge.customer)
			c = Charge.find_by(ch_id: charge.id)
			if c.nil?
				c = Charge.new(
					amount: charge.amount,
					cus: charge.customer,
					user_id: user.id,
					ch_id: charge.id,
					txn_id: charge.balance_transaction,
					address: charge.source.owner.address.line1,
					city: charge.source.owner.address.city,
					state: charge.source.owner.address.state,
					postal_code: charge.source.owner.address.postal_code,
					source: charge.source.id,
					charge_status: charge.status,
				)
				c.save
			else
				c.update(
					amount: charge.amount,
					cus: charge.customer,
					user_id: user.id,
					ch_id: charge.id,
					txn_id: charge.balance_transaction,
					address: charge.source.owner.address.line1,
					city: charge.source.owner.address.city,
					state: charge.source.owner.address.state,
					postal_code: charge.source.owner.address.postal_code,
					source: charge.source.id,
					charge_status: charge.status,
				)
			end
		end
	end
end