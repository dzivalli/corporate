class Web::Counterparties::OfficialsController < Web::Counterparties::ApplicationController
  add_breadcrumb

  def show
    @official = Counterparty::Official.find(params[:id])
    authorize @official
    add_breadcrumb model: @official
  end

  def new
    @official = resource_counterparty.officials.build
    authorize @official
  end

  def create
    @official = resource_counterparty.officials.build official_params
    authorize @official
    add_breadcrumb
    @official.save
    respond_with @official, location: resource_counterparty
  end

  def edit
    @official = Counterparty::Official.find params[:id]
    authorize @official
    add_breadcrumb model: @official
    respond_with @official
  end

  def update
    @official = Counterparty::Official.find params[:id]
    authorize @official
    add_breadcrumb model: @official
    @official.update official_params
    respond_with @official, location: counterparty_official_path(@official.counterparty, @official)
  end

  def official_params
    params.require(:counterparty_official).permit(:name, :position, :contractor_id, :contacts)
  end
end
