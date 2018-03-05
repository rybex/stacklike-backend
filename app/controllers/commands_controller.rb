class CommandsController < ApplicationController
  include CommandsBus
  include Auth

  before_action :require_user

  def apply
    commands_bus.(merge_creator_id(params))
    render json: 'OK', status: 201
  rescue Domain::Error,
         Infrastructure::CommandBus::CommandDoesNotExists => error
    render json: error.message, status: 404
  rescue Infrastructure::Command::ValidationError => error
    render json: error.errors, status: 422
  end

  private

  def require_user
    render json: 'You must login to call this endpoint', status: 401 unless current_user
  end

  def merge_creator_id(params)
    params  = params.to_h
    payload = params.fetch('payload', {}).merge('creator_id' => current_user.id)
    params.merge('payload' => payload)
  end
end
