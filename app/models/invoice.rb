class Invoice < ActiveRecord::Base
	has_many :lines, :dependent => :destroy
	belongs_to :client
	belongs_to :project

	default_scope { order('paiddate DESC') }

	scope :paid, -> { where(paid: true) }
	scope :unpaid, -> { where.not(paid: true) }
	scope :recent, -> { where("SELECT extract(MONTH FROM paiddate) = ? AND extract(YEAR FROM paiddate) = ?", Date.today.month, Date.today.year) }

	scope :contract, -> { where(worktype: 'Contract') }
	scope :hourly, -> { where(worktype: 'Hourly') }
	scope :retainer, -> { where(worktype: 'Retainer') }

	scope :paidByYear, -> (year) { paid.where("SELECT extract(YEAR FROM paiddate) = ?", year) }
	scope :paidByMonth, -> (date) { paid.where("SELECT extract(YEAR FROM paiddate) = ? AND extract(MONTH FROM paiddate) = ?", date.year, date.month) }

	scope :paidByQ1, -> (year) { paid.where("paiddate >= ? AND paiddate <= ?", Date.new(year, 1, 1), Date.new(year, 3, 31)) }
	scope :paidByQ2, -> (year) { paid.where("paiddate >= ? AND paiddate <= ?", Date.new(year, 4, 1), Date.new(year, 6, 30)) }
	scope :paidByQ3, -> (year) { paid.where("paiddate >= ? AND paiddate <= ?", Date.new(year, 7, 1), Date.new(year, 9, 30)) }
	scope :paidByQ4, -> (year) { paid.where("paiddate >= ? AND paiddate <= ?", Date.new(year, 10, 1), Date.new(year, 12, 31)) }

end
