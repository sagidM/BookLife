class PublishingHousesController < ApplicationController
  def index
    @query = params[:q].to_s
    if @query.blank?
      @publishing_houses = PublishingHouse.all.order('id desc')
    else
      @publishing_houses = PublishingHouse.where('lower(name) like ?', "%#{@query.strip.downcase}%").order('id desc')
    end
  end

  def new
    @publishing_house = PublishingHouse.new
  end

  def create
    @publishing_house = PublishingHouse.new ph_params
    if @publishing_house.save
      notice = "Издательство #{@publishing_house.name} успешно добавлено"
      redirect_to publishing_houses_path, notice: notice
    else
      flash.now[:errors] = @publishing_house.errors.messages
      render :new
    end
  end

  def destroy
    id = params[:id]
    Book.where('publishing_house_id=?', id).destroy_all
    name = PublishingHouse.find(id).destroy.name
    redirect_to publishing_houses_path, notice: "Издательство #{name} успешно удалено"
  end

  private
    def ph_params
      params.require(:publishing_house).permit :name, :description, :year_of_foundation, :logo, :remote_logo_url
    end
end
