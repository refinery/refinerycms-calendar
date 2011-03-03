module NavigationHelpers
  module Refinery
    module EventsEngine
      def path_to(page_name)
        case page_name
        when /the list of events/
          admin_events_path

         when /the new events form/
          new_admin_events_path
        else
          nil
        end
      end
    end
  end
end
