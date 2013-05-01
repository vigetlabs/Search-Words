require 'spec_helper'

describe SearchWordApp do
  describe "homepage" do
    before { visit "/" }

    it "displays usage instructions" do
      page.should have_content("Upload a CSV")
    end

    it "displays an upload form" do
      page.should have_selector("form")
    end

    describe "submitting the upload form" do
      context "with a csv file" do
        before do
          attach_file "file", "#{settings.root}/spec/fixtures/files/sample.csv"
          click_button :submit
        end

        it "displays a success message" do
          page.should have_content("file is ready")
        end

        it "displays a download link" do
          page.should have_selector("a.file-download")
        end

        it "displays the upload form" do
          page.should have_selector("form")
        end
      end

      context "with a non-csv file" do
        before do
          attach_file "file", "#{settings.root}/spec/fixtures/files/sample.txt"
          click_button :submit
        end

        it "displays an error message" do
          page.should have_content("Please select a .csv file.")
        end

        it "displays the upload form" do
          page.should have_selector("form")
        end
      end
    end
  end

  describe "file download" do
    before do
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
      "lemur,3000\ndurham,60\nbull,55\nfighting,10\nblank,0\n"
    end
  end
end
