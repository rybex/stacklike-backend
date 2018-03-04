class SearchesController < ApplicationController
  def apply
    questions = Readmodel::Search.(params)
    render json: questions, status: 200
  end
end
