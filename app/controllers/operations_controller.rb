class OperationsController < ApplicationController
  before_action :set_operation, only: %i[show edit update destroy]
  before_action :authenticate_user!

  # GET /operations or /operations.json
  def index
    @group = Group.find(params[:group_id])
    @operations = @group.operations.order(created_at: :desc)
  end

  # GET /operations/1 or /operations/1.json
  def show; end

  # GET /operations/new
  def new
    @group = Group.find(params[:group_id])
    @operation = Operation.new
  end

  # GET /operations/1/edit
  def edit; end

  # POST /operations or /operations.json
  def create
    @group = Group.find(params[:group_id])
    @operation = Operation.new(operation_params)
    @operation.author = current_user.name
    @operation.user = current_user
    @operation.groups.push(@group) unless @operation.groups.include?(@group)

    respond_to do |format|
      if @operation.save
        format.html { redirect_to group_operations_url(@group), notice: 'Operation was successfully created.' }
        format.json { render :show, status: :created, location: @operation }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @operation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /operations/1 or /operations/1.json
  def update
    respond_to do |format|
      if @operation.update(operation_params)
        format.html { redirect_to operation_url(@operation), notice: 'Operation was successfully updated.' }
        format.json { render :show, status: :ok, location: @operation }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @operation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /operations/1 or /operations/1.json
  def destroy
    @operation.destroy

    respond_to do |format|
      format.html { redirect_to operations_url, notice: 'Operation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_operation
    @operation = Operation.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def operation_params
    params.require(:operation).permit(:author, :references, :name, :amount)
  end
end
