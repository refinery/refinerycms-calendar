module Refinery
  module Calendar
    module Admin
      class VenuesController < ::Refinery::AdminController

        crudify :'refinery/calendar/venue',
                title_attribute: 'name',
                sortable: false,
                order: 'created_at DESC'

        protected

        def venue_params
          params.require(:venue).permit(permitted_venue_params)
        end

        private

        def permitted_venue_params
          [
            :name, :address, :url, :phone, :position
          ]
        end
      end
    end
  end
end
