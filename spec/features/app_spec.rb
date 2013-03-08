require 'spec_helper'

describe SearchWordApp do
  describe "homepage" do
    before { visit "/" }

    it "displays usage instructions" do
      page.should have_content("Upload CSV")
    end

    it "displays an upload form" do
      page.should have_selector("form")
    end

    describe "submitting the upload form" do
      before do
        attach_file "file", "#{settings.root}/spec/fixtures/files/sample.csv"
        click_button :submit
      end

      it "displays a success message" do
        page.should have_content("Processing Complete")
      end

      it "displays a download link" do
        page.should have_selector("a.file-download")
      end

      it "displays the upload form" do
        page.should have_selector("form")
      end
    end
  end

  describe "file download" do
    before do
      Word.clear_list
      visit "/"
      attach_file "file", "#{settings.root}/spec/fixtures/files/sample.csv"
      click_button :submit
      click_link "Download processed file."
    end

    it "downloads a file with properly processed data" do
      page.response_headers["Content-Disposition"].should == "attachment; filename=\"processed_sample.csv\""
      page.source.should == properly_processed_file_content
    end

    def properly_processed_file_content
      "lemur,3000\ndurham,60\nbull,55\nfighting,10\n"
    end
  end
end
