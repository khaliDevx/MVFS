class AdditionsController < ApplicationController
    layout 'application'
    before_action :check_login
  before_action :check_type, except: :help

    def help 

    end
    def addition
        @gover = Governorate.all
        @cat = Category.all
        @city = City.all
    end
    def new_gover
        gover = Governorate.new(gover_params)

        if gover.save 
            redirect_to '/addition'
        else
            redirect_to '/addition'
        end
    end
    def new_city
        city = City.new(city_params)
        if city.save 
            redirect_to '/addition'
        else
            redirect_to '/addition'
        end
    end
    def new_cat
        cat = Category.new(cat_params)
        if cat.save 
            redirect_to '/addition'
        else
            redirect_to '/addition'
        end
    end
    def new_mat
        mat = Material.new(mat_params)
        if mat.save 
            redirect_to '/addition'
        else
            redirect_to '/addition'
        end
    end

    def create_area
        area = Area.new(area_params)
        if area.save
            redirect_to '/addition'
        else
            redirect_to '/addition'
        end

    end

   

    private
        def gover_params
            params.require(:gover).permit(:name)
        end
        def city_params
            params.require(:city).permit(:name, :governorate_id)
        end
        def cat_params
            params.require(:cat).permit(:name)
        end
        def mat_params
            params.require(:mat).permit(:name, :category_id)
        end
        def area_params
            params.require(:area).permit(:name, :city_id)
        end
end
