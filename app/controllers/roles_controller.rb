# Company roles
class RolesController < ApplicationController
  before_action :load_company
  before_action :load_resource, only: %i[show edit update destroy]

  # GET /companies/5/roles
  # GET /companies/5/roles.json
  def index
    @roles = @company.roles.ordered
    @roles = @roles.search(params[:sSearch]) if params.try(:[], :sSearch).present?
    @roles = @roles.page(page).per(per_page)
  end

  # GET /companies/5/roles/1
  # GET /companies/5/roles/1.json
  def show; end

  # GET /companies/5/roles/new
  def new
    @role = @company.roles.new
  end

  # GET /companies/5/roles/1/edit
  def edit; end

  # POST /companies/5/roles
  # POST /companies/5/roles.json
  def create
    @role = @company.roles.new(safe_params)

    respond_to do |format|
      if @role.save
        format.html { redirect_to [@company, @role], notice: 'Role was successfully created.' }
        format.json { render :show, status: :created, location: @role }
      else
        format.html { render :new }
        format.json { render json: @role.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /companies/5/roles/1
  # PATCH/PUT /companies/5/roles/1.json
  def update
    respond_to do |format|
      if @role.update(safe_params)
        format.html { redirect_to [@company, @role], notice: 'Role was successfully updated.' }
        format.json { render :show, status: :ok, location: @role }
      else
        format.html { render :edit }
        format.json { render json: @role.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /companies/5/roles/1
  # DELETE /companies/5/roles/1.json
  def destroy
    @role.destroy
    respond_to do |format|
      format.html { redirect_to company_roles_url(@company), notice: 'Role was successfully removed.' }
      format.json { head :no_content }
    end
  end

  private

  def load_company
    @company = Company.find(params[:company_id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def load_resource
    @role = Role.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def safe_params
    safe_attributes = %i[name key]
    params.require(:role).permit(safe_attributes)
  end

  def page
    params[:iDisplayStart].to_i / (per_page + 1)
  end

  def per_page
    (params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : @roles.count)
  end
end
