class InvoicesController < ApplicationController
  before_action :set_invoice, only: [:show, :edit, :update, :destroy]

  def index
    @invoices = Invoice.all
  end

  def show
  	respond_to do |format|
      format.html
      format.pdf do
        render 	:pdf => Client.find(@invoice.clientid).name.gsub(/[^0-9A-Za-z]/, '') + @invoice.date.to_s,
        				:disposition => 'inline',
        				:page_size => 'Letter',
        				:layout => 'layouts/pdf/invoice.html',
        				:template => 'invoices/show.pdf.erb',
        				:disable_internal_links => true,
        				:disable_external_links => true,
        				:greyscale => false,
        				:lowquality => false
      end
    end
  end

  def new
    @invoice = Invoice.new
  end

  def edit
  end

  def create
    @invoice = Invoice.new(invoice_params)

    respond_to do |format|
      if @invoice.save
        format.html { redirect_to @invoice, notice: 'Invoice was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def update
    respond_to do |format|
      if @invoice.update(invoice_params)
        format.html { redirect_to @invoice, notice: 'Invoice was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def destroy
    @invoice.destroy
    respond_to do |format|
      format.html { redirect_to invoices_url }
    end
  end

  private
    def set_invoice
      @invoice = Invoice.find(params[:id])
    end

    def invoice_params
      params.require(:invoice).permit(:clientid, :projectid, :date, :worktype, :cost, :paid, :paiddate, :paymenttype, :description)
    end
end