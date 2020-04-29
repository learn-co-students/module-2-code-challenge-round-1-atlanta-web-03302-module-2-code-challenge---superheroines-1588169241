class PowersController < ApplicationController
  def index
    @powers = Power.all
  end

  def show
    @power = Power.find_by(id: params[:id])
  end

  def edit
    @power = Power.find_by(id: params[:id])
    @heroines = Heroine.all
  end

  def update
    @power = Power.find_by(id: params[:id])

    if @power.update(power_params)
      if !params[:heroine_ids].empty?
        params[:heroine_ids].each do |heroine|
          @heroine = Heroine.find_by(id: heroine)
          if !@heroine.powers.include?(@power)
            @heroine.powers << @power
          end
        end
      end
      redirect_to power_path(@power)
    else
      render :edit
    end
  end

  private
    def power_params
      params.require(:power).permit(:name, :description, :heroine_ids)
    end
end
