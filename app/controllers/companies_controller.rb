# RESTful controller for Companies
class CompaniesController < ApplicationController
  before_action :load_resource, only: %i[show edit update destroy]

  # GET /companies
  # GET /companies.json
  def index
    @companies = Company.ordered
    @companies = @companies.search(params[:sSearch]) if params.try(:[], :sSearch).present?
    @companies = @companies.page(page).per(per_page)
  end

  # GET /companies/1
  # GET /companies/1.json
  def show; end

  # GET /companies/new
  def new
    @company = Company.new
  end

  # GET /companies/1/edit
  def edit; end

  # POST /companies
  # POST /companies.json
  def create
    @company = Company.new(safe_params)

    respond_to do |format|
      if @company.save
        format.html { redirect_to @company, notice: 'Company was successfully created.' }
        format.json { render :show, status: :created, location: @company }
      else
        format.html { render :new }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /companies/1
  # PATCH/PUT /companies/1.json
  def update
    respond_to do |format|
      if @company.update(safe_params)
        format.html { redirect_to @company, notice: 'Company was successfully updated.' }
        format.json { render :show, status: :ok, location: @company }
      else
        format.html { render :edit }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.json
  def destroy
    @company.destroy
    respond_to do |format|
      format.html { redirect_to companies_url, notice: 'Company was successfully removed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def load_resource
    @company = Company.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def safe_params
    safe_attributes = %i[name active]
    params.require(:company).permit(safe_attributes)
  end

  def page
    params[:iDisplayStart].to_i / (per_page + 1)
  end

  def per_page
    (params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : @companies.count)
  end
end
