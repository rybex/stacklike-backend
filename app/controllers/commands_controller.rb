class CommandsController < ApplicationController
  include CommandsBus

  def apply
    begin
      commands_bus.call(params)
      render json: 'OK', status: 201
    rescue Domain::Error,
           Infrastructure::CommandBus::CommandDoesNotExists=> error
      render json: error.message, status: 404
    rescue Infrastructure::Command::ValidationError => error
      render json: error.errors, status: 422
    end
  end
end
