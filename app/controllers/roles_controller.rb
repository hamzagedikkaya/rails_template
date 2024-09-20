class RolesController < ApplicationController
  load_and_authorize_resource

  def index
    @roles = Role.all
  end

  def new
    @role = Role.new
  end

  def create
    @role = Role.new(role_params)
    if @role.save
      redirect_to roles_path, notice: "Role was successfully created."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @role.update(role_params)
      redirect_to roles_path, notice: "Role was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @role.destroy
    redirect_to roles_path, notice: "Role was successfully deleted."
  end

  def assign
    @users = User.all
    @roles = Role.all
  end

  def create_assignment
    user_ids = params[:assignment][:user_ids].reject(&:blank?)
    role_ids = params[:assignment][:role_ids].reject(&:blank?)

    if user_ids.empty? || role_ids.empty?
      flash[:error] = "Please select at least one user and one role."
      redirect_to assign_roles_path and return
    end

    user_ids.each do |user_id|
      user = User.find(user_id)
      role_ids.each do |role_id|
        role = Role.find(role_id)
        user.add_role(role.name)
      end
    end

    flash[:success] = "Roles assigned successfully!"
    redirect_to create_assignment_roles_path
  end

  private

  def role_params
    params.require(:role).permit(:name, :description)
  end
end
