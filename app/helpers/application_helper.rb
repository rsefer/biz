module ApplicationHelper

	def company_full_name
		'Sefer Design Company'
	end
	def company_abbrv_name
		'Sefer Design Co.'
	end
	def company_initialed_name
		'SDC'
	end
	def company_site_url
		'http://seferdesign.com'
	end
	def company_logo_url
		'/images/sdc_block_dark.svg'
	end
	def company_logo_alt_url
		'/images/sdc_block_white.svg'
	end
	def company_text_logo_url
		'/images/sdc_text_dark.svg'
	end
	def company_text_logo_alt_url
		'/images/sdc_text_white.svg'
	end
	def company_favicon_url
		'/images/sdc_favicon_144.png'
	end
	def company_pay_to
		'Robert Sefer'
	end
	def company_phone
		'(630) 204-0013'
	end
	def company_email
		'rsefer@gmail.com'
	end
	def company_email_invoice
		'info@seferdesign.com'
	end
	def company_street
		'1 E. Scott #1402'
	end
	def company_city
		'Chicago'
	end
	def company_state
		'Illinois'
	end
	def company_state_abbrv
		'IL'
	end
	def company_zipcode
		'60610'
	end

	def total_invoiced_unpaid
		Invoice.unpaid.sum('cost')
	end

	def invoice_description_suffix
		'Find below a cost-breakdown for the recent work completed.'
	end

	def invoice_description_suffix_pleasepay
		'Please make payment at your earliest convenience, and do not hesitate to contact me with any questions.'
	end

	def payment_types
		[
			'Check',
			'Cash',
			'Credit Card',
			'Chase Quick Pay',
			'PayPal',
			'ACH',
			'Venmo',
			'Other'
		]
	end

	def us_states
    [
      ['Alabama', 'AL'],
      ['Alaska', 'AK'],
      ['Arizona', 'AZ'],
      ['Arkansas', 'AR'],
      ['California', 'CA'],
      ['Colorado', 'CO'],
      ['Connecticut', 'CT'],
      ['Delaware', 'DE'],
      ['District of Columbia', 'DC'],
      ['Florida', 'FL'],
      ['Georgia', 'GA'],
      ['Hawaii', 'HI'],
      ['Idaho', 'ID'],
      ['Illinois', 'IL'],
      ['Indiana', 'IN'],
      ['Iowa', 'IA'],
      ['Kansas', 'KS'],
      ['Kentucky', 'KY'],
      ['Louisiana', 'LA'],
      ['Maine', 'ME'],
      ['Maryland', 'MD'],
      ['Massachusetts', 'MA'],
      ['Michigan', 'MI'],
      ['Minnesota', 'MN'],
      ['Mississippi', 'MS'],
      ['Missouri', 'MO'],
      ['Montana', 'MT'],
      ['Nebraska', 'NE'],
      ['Nevada', 'NV'],
      ['New Hampshire', 'NH'],
      ['New Jersey', 'NJ'],
      ['New Mexico', 'NM'],
      ['New York', 'NY'],
      ['North Carolina', 'NC'],
      ['North Dakota', 'ND'],
      ['Ohio', 'OH'],
      ['Oklahoma', 'OK'],
      ['Oregon', 'OR'],
      ['Pennsylvania', 'PA'],
      ['Puerto Rico', 'PR'],
      ['Rhode Island', 'RI'],
      ['South Carolina', 'SC'],
      ['South Dakota', 'SD'],
      ['Tennessee', 'TN'],
      ['Texas', 'TX'],
      ['Utah', 'UT'],
      ['Vermont', 'VT'],
      ['Virginia', 'VA'],
      ['Washington', 'WA'],
      ['West Virginia', 'WV'],
      ['Wisconsin', 'WI'],
      ['Wyoming', 'WY']
    ]
	end

	def today
		Date.today
	end

end
