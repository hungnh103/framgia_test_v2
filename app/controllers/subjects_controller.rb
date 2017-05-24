class SubjectsController < ApplicationController
  load_and_authorize_resource

  def show
    respond_to do |format|
      format.html
      format.docx do
        render docx: "show", filename: "#{@subject.name}.docx"
      end
    end
  end
end
