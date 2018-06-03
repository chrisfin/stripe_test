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

	class ChargePending
		def call(event)
			charge = event.data.object
			user = User.find_by(cus: charge.customer)
			c = Charge.find_by(ch_id: charge.id)
			if c.nil?
				c = Charge.new(
					charge_status: charge.status,
				)
				c.save
			else
				c.update(
					charge_status: charge.status,
				)
			end
		end
	end

	class ChargeFailed
		def call(event)
			charge = event.data.object
			user = User.find_by(cus: charge.customer)
			c = Charge.find_by(ch_id: charge.id)
			if c.nil?
				c = Charge.new(
					charge_status: charge.status,
				)
				c.save
			else
				c.update(
					charge_status: charge.status,
				)
			end
		end
	end

	class AccountUpdated
		def call(event)
			account = event.data.object
			e = Editor.find_by(acct_id: account.id)
			e.update!(
				verification_status_le: account.legal_entity.verification.status,
				verification_disabled_reason: account.verification.disabled_reason,
				verification_fields_needed: account.verification.fields_needed,
				payouts_enabled: account.payouts_enabled,
				)
		end
	end

	class AccountExternalAccountUpdated
		def call(event)
			account = event.data.object
			e = Editor.find_by(acct_id: account.account)
			e.update(
				ba_id: account.id
				)
		end
	end

	class AccountExternalAccountCreated
		def call(event)
			account = event.data.object
			e = Editor.find_by(acct_id: account.account)
			e.update(
				ba_id: account.id
				)
		end
	end
end