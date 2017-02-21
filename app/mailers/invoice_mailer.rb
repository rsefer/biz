class InvoiceMailer < ActionMailer::Base

  default from: "Sefer Design Co. <info@seferdesign.com>"
  helper :application

  def invoice_email(invoice)
    @invoice = invoice

    cc_list = ["Robert Sefer <rsefer@gmail.com>"]
    if invoice.client.email_accounting_2.present?
      cc_list.push(invoice.client.email_accounting_2)
    end
    if invoice.client.email_accounting_3.present?
      cc_list.push(invoice.client.email_accounting_3)
    end

    email_html_raw = render_to_string(:layout => 'layouts/mail.html', :action => 'invoice_email.html', :locals => { :invoice => @invoice })
    html_roadie = Roadie::Document.new email_html_raw
    html_inlined = html_roadie.transform

    pdfFileName = invoice.pdfFileName

    if invoice.paid == true
      pdfFileName = pdfFileName + '_paid'
    end

    pdf = render_to_string(
      :layout => 'pdf/invoice.html',
      :template => 'invoices/show.pdf.erb'
    ).force_encoding('UTF-8').encode('UTF-8', { :invalid => :replace, :undef => :replace, :replace => '?' })
    tempPDF = WickedPdf.new.pdf_from_string(pdf, :encoding => 'UTF-8', :page_size => 'Letter')
    encodedPDF = Base64.encode64(tempPDF)

    require 'tempfile'

    Tempfile.open('prefix', Rails.root.join('tmp')) do |f|
      f.binmode
      f.write tempPDF
      session = GoogleDrive::Session.from_config('config/google.json')
      file = session.upload_from_file(f, "#{pdfFileName}.pdf", convert: false)
      session.collection_by_url(Figaro.env.google_drive_invoices_unpaid_folder_url).add(file)
      session.root_collection.remove(file)
      f.unlink
    end

    mail(to: "#{invoice.client.contact} <#{invoice.client.email_accounting}>", subject: "Invoice from Sefer Design Company", cc: cc_list) do |format|
      format.html do
        html_inlined
      end
      format.pdf do
        attachments["#{pdfFileName}.pdf"] = WickedPdf.new.pdf_from_string(pdf, :encoding => 'UTF-8', :page_size => 'Letter')
      end
    end

  end

end
