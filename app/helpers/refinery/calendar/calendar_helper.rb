require 'date'

# CalendarHelper allows you to draw a databound calendar with fine-grained CSS formatting
# https://github.com/topfunky/calendar_helper
module Refinery::Calendar::CalendarHelper

  VERSION = '0.2.4'

  # Returns an HTML calendar. In its simplest form, this method generates a plain
  # calendar (which can then be customized using CSS) for a given month and year.
  # However, this may be customized in a variety of ways -- changing the default CSS
  # classes, generating the individual day entries yourself, and so on.
  #
  # The following options are required:
  #  :year  # The  year number to show the calendar for.
  #  :month # The month number to show the calendar for.
  #
  # The following are optional, available for customizing the default behaviour:
  #   :table_id          => "calendar-2008-08"                  # The id for the <table> tag.
  #   :table_class       => "calendar"                          # The class for the <table> tag.
  #   :summary           => "Calendar for August 2008"          # The summary attribute for the <table> tag.  Required for 508 compliance.
  #   :month_name_class  => "monthName"                         # The class for the name of the month, at the top of the table.
  #   :other_month_class => "otherMonth"                        # Not implemented yet.
  #   :day_name_class    => "dayName"                           # The class is for the names of the weekdays, at the top.
  #   :day_class         => "day"                               # The class for the individual day number cells.
  #                                                               This may or may not be used if you specify a block (see below).
  #   :abbrev            => true                                # This option specifies whether day names should be displayed abbrevidated (true)
  #                                                               or in full (false)
  #   :first_day_of_week => 0                                   # Renders calendar starting on Sunday. Use 1 for Monday, and so on.
  #   :accessible        => true                                # Turns on accessibility mode. This suffixes dates within the
  #                                                             # calendar that are outside the range defined in the <caption> with
  #                                                             # <span class="hidden"> MonthName</span>
  #                                                             # Defaults to false.
  #                                                             # You'll need to define an appropriate style in order to make this disappear.
  #                                                             # Choose your own method of hiding content appropriately.
  #
  #   :show_today        => false                               # Highlights today on the calendar using the CSS class 'today'.
  #                                                             # Defaults to true.
  #   :previous_month_text   => nil                             # Displayed left of the month name if set
  #   :next_month_text   => nil                                 # Displayed right of the month name if set
  #   :month_header      => false                               # If you use false, the current month header will disappear.
  #   :calendar_title    => month_names[options[:month]]        # Pass in a custom title for the calendar. Defaults to month name
  #
  # For more customization, you can pass a code block to this method, that will get one argument, a Date object,
  # and return a values for the individual table cells. The block can return an array, [cell_text, cell_attrs],
  # cell_text being the text that is displayed and cell_attrs a hash containing the attributes for the <td> tag
  # (this can be used to change the <td>'s class for customization with CSS).
  # This block can also return the cell_text only, in which case the <td>'s class defaults to the value given in
  # +:day_class+. If the block returns nil, the default options are used.
  #
  # Example usage:
  #   calendar(:year => 2005, :month => 6) # This generates the simplest possible calendar.
  #   calendar({:year => 2005, :month => 6, :table_class => "calendar_helper"}) # This generates a calendar, as
  #                                                                             # before, but the <table>'s class
  #                                                                             # is set to "calendar_helper".
  #   calendar(:year => 2005, :month => 6, :abbrev => (0..-1)) # This generates a simple calendar but shows the
  #                                                            # entire day name ("Sunday", "Monday", etc.) instead
  #                                                            # of only the first three letters.
  #   calendar(:year => 2005, :month => 5) do |d| # This generates a simple calendar, but gives special days
  #     if listOfSpecialDays.include?(d)          # (days that are in the array listOfSpecialDays) one CSS class,
  #       [d.mday, {:class => "specialDay"}]      # "specialDay", and gives the rest of the days another CSS class,
  #     else                                      # "normalDay". You can also use this highlight today differently
  #       [d.mday, {:class => "normalDay"}]       # from the rest of the days, etc.
  #     end
  #   end
  #
  # An additional 'weekend' class is applied to weekend days.
  #
  # For consistency with the themes provided in the calendar_styles generator, use "specialDay" as the CSS class for marked days.
  #
  # Accessibility & 508 Compliance:
  #   The table tag has a summary attribute (overridable).
  #   Each th has an id.
  #   Each td has a headers attribute, containing the element id of the appropriate th.
  #
  def calendar(options = {}, &block)
    raise(ArgumentError, "No year given")  unless options.has_key?(:year)
    raise(ArgumentError, "No month given") unless options.has_key?(:month)

    block                        ||= Proc.new do |d|
      if Refinery::Calendar::Event.on_day(d).count > 0
      [link_to(d.day, refinery.calendar_events_path(date: d)), class: "day-with-events"]
      else
        d.day
      end
    end

    month_names = (!defined?(I18n) || I18n.t("date.month_names").include?("missing")) ? Date::MONTHNAMES.dup : I18n.t("date.month_names")

    month_names = (!defined?(I18n) || I18n.t("date.month_names").include?("missing")) ? Date::MONTHNAMES.dup : I18n.t("date.month_names")

    defaults = {
      :table_id            => "calendar-#{options[:year]}-#{"0%d" % options[:month]}",
      :table_class         => 'calendar',
      :month_name_class    => 'monthName',
      :other_month_class   => 'otherMonth',
      :day_name_class      => 'dayName',
      :day_class           => 'day',
      :abbrev              => true,
      :first_day_of_week   => 0,
      :accessible          => false,
      :show_today          => true,
      :previous_month_text => nil,
      :next_month_text     => nil,
      :month_header        => true,
      :calendar_title      => month_names[options[:month]],
      :summary             => "Calendar for #{month_names[options[:month]]} #{options[:year]}"
    }
    options = defaults.merge options

    first = Date.civil(options[:year], options[:month], 1)
    last = Date.civil(options[:year], options[:month], -1)

    first_weekday = first_day_of_week(options[:first_day_of_week])
    last_weekday = last_day_of_week(options[:first_day_of_week])

    day_names = (!defined?(I18n) || I18n.t("date.day_names").include?("missing")) ? Date::DAYNAMES.dup : I18n.t("date.day_names").dup
    abbr_day_names = (!defined?(I18n) || I18n.t("date.abbr_day_names").include?("missing")) ? Date::ABBR_DAYNAMES.dup : I18n.t("date.abbr_day_names").dup
    first_weekday.times do
      day_names.push(day_names.shift)
      abbr_day_names.push(abbr_day_names.shift)
    end

    # TODO Use some kind of builder instead of straight HTML
    cal = %(<table id="#{options[:table_id]}" class="#{options[:table_class]}" border="0" cellspacing="0" cellpadding="0" summary="#{options[:summary]}">)
    cal << %(<thead>)

    if (options[:month_header])
      cal << %(<tr>)
      if options[:previous_month_text] or options[:next_month_text]
        cal << %(<th colspan="2">#{options[:previous_month_text]}</th>)
        colspan=3
      else
        colspan=7
      end
      cal << %(<th colspan="#{colspan}" class="#{options[:month_name_class]}">#{options[:calendar_title]}</th>)
      cal << %(<th colspan="2">#{options[:next_month_text]}</th>) if options[:next_month_text]
      cal << %(</tr>)
    end

    cal << %(<tr class="#{options[:day_name_class]}">)

    day_names.each_with_index do |day_name, index|
      cal << %(<th id="#{th_id(day_name, options[:table_id])}" scope='col'>)
      cal << (options[:abbrev] ? %(<abbr title='#{day_name}'>#{abbr_day_names[index]}</abbr>) : day_name)
      cal << %(</th>)
    end

    cal << "</tr></thead><tbody><tr>"

    # previous month
    beginning_of_week(first, first_weekday).upto(first - 1) do |d|
      cal << generate_other_month_cell(d, options)
    end unless first.wday == first_weekday

    first.upto(last) do |cur|
      cell_text, cell_attrs = block.call(cur)
      cell_text  ||= cur.mday
      cell_attrs ||= {}
      cell_attrs[:headers] = th_id(cur, options[:table_id])
      cell_attrs[:class] ||= options[:day_class]
      cell_attrs[:class] += " weekendDay" if [0, 6].include?(cur.wday)
      today = (Time.respond_to?(:zone) && !(zone = Time.zone).nil? ? zone.now.to_date : Date.today)
      cell_attrs[:class] += " today" if (cur == today) and options[:show_today]

      cal << generate_cell(cell_text, cell_attrs)
      cal << "</tr><tr>" if cur.wday == last_weekday
    end

    # next month
    (last + 1).upto(beginning_of_week(last + 7, first_weekday) - 1)  do |d|
      cal << generate_other_month_cell(d, options)
    end unless last.wday == last_weekday

    cal << "</tr></tbody></table>"
    cal.respond_to?(:html_safe) ? cal.html_safe : cal
  end

  def date_events_path(area, date, month_date)
    params = {}
    params[:month_date] = month_date.strftime("%m-%Y") unless month_date.blank?
    params[:date] = date.strftime("%d-%m-%Y") unless date.blank?
    area.blank? ? events_path(params) : area_events_path(area, params)
  end

  private

  def first_day_of_week(day)
    day
  end

  def last_day_of_week(day)
    if day > 0
      day - 1
    else
      6
    end
  end

  def days_between(first, second)
    if first > second
      second + (7 - first)
    else
      second - first
    end
  end

  def beginning_of_week(date, start = 1)
    days_to_beg = days_between(start, date.wday)
    date - days_to_beg
  end

  def generate_cell(cell_text, cell_attrs)
    cell_attrs = cell_attrs.map {|k, v| %(#{k}="#{v}") }.join(" ")
    "<td #{cell_attrs}>#{cell_text}</td>"
  end

  def generate_other_month_cell(date, options)
    cell_attrs = {}
    cell_attrs[:headers] = th_id(date, options[:table_id])
    cell_attrs[:class] = options[:other_month_class]
    cell_attrs[:class] += " weekendDay" if weekend?(date)

    cell_text = date.day
    if options[:accessible]
      cell_text += %(<span class="hidden"> #{month_names[date.month]}</span>)
    end

    generate_cell(date.day, cell_attrs)
  end

  # Calculates id for th element.
  #   derived from calendar_id and dow.
  #
  # Params:
  #   `day` can be either Date or DOW('Sunday', 'Monday')
  def th_id(day, calendar_id)
    return th_id(Date::DAYNAMES[day.wday], calendar_id) if day.is_a?(Date)
    "#{calendar_id}-#{day[0..2].downcase}"
  end

  def weekend?(date)
    [0, 6].include?(date.wday)
  end

end
