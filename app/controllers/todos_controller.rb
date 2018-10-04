class TodosController < ApplicationController
  before_action :load_todo, only: %i(show update destroy)

  def index
    @todos = Todo.all
    json_response @todos
  end

  def create
    @todo = Todo.create! todo_params
    json_response(@todo, :created)
  end

  def show
    json_response @todo
  end

  def update
    @todo.update todo_params
    head :no_content
  end

  def destroy
    @todo.destroy
    head :no_content
  end

  private

  def todo_params
    params.permit(:title, :created_by)
  end

  def load_todo
    @todo = Todo.find_by(id: params[:id]) || not_found
  end
end
