module NavigationHelpers
  module Refinery
    module Events
      def path_to(page_name)
        case page_name
        when /the list of events/
          admin_events_path

         when /the new event form/
          new_admin_event_path
        else
          nil
        end
      end
    end
  end
end
