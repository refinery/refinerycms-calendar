module Refinery
  module Calendar
    module Admin
      class VenuesController < ::Refinery::AdminController

        crudify :'refinery/calendar/venue',
                :title_attribute => 'name',
                :xhr_paging => true,
                :sortable => false,
                :order => 'created_at DESC'
      end
    end
  end
end
