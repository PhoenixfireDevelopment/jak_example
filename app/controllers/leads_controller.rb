# Leads for a company
class LeadsController < ApplicationController
  before_action :load_company
  before_action :load_resource, only: %i[show edit update destroy]

  # GET /companies/5/leads
  # GET /companies/5/leads.json
  def index
    @leads = @company.leads.ordered
    @leads = @leads.search(params[:sSearch]) if params.try(:[], :sSearch).present?
    @leads = @leads.page(page).per(per_page)
  end

  # GET /companies/5/leads/1
  # GET /companies/5/leads/1.json
  def show; end

  # GET /companies/5/leads/new
  def new
    @lead = @company.leads.new
  end

  # GET /leads/1/edit
  def edit; end

  # POST /companies/5/leads
  # POST /companies/5/leads.json
  def create
    @lead = @company.leads.new(safe_params)

    respond_to do |format|
      if @lead.save
        format.html { redirect_to [@company, @lead], notice: 'Lead was successfully created.' }
        format.json { render :show, status: :created, location: @lead }
      else
        format.html { render :new }
        format.json { render json: @lead.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /companies/5/leads/1
  # PATCH/PUT /companies/5/leads/1.json
  def update
    respond_to do |format|
      if @lead.update(safe_params)
        format.html { redirect_to [@company, @lead], notice: 'Lead was successfully updated.' }
        format.json { render :show, status: :ok, location: @lead }
      else
        format.html { render :edit }
        format.json { render json: @lead.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /companies/5/leads/1
  # DELETE /companies/5/leads/1.json
  def destroy
    @lead.destroy
    respond_to do |format|
      format.html { redirect_to company_leads_url(@company), notice: 'Lead was successfully removed.' }
      format.json { head :no_content }
    end
  end

  private

  def load_company
    @company = Company.find(params[:company_id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def load_resource
    @lead = Lead.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def safe_params
    safe_attributes = %i[name assignable_id]
    params.require(:lead).permit(safe_attributes)
  end

  def page
    params[:iDisplayStart].to_i / (per_page + 1)
  end

  def per_page
    (params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : @leads.count)
  end
end
