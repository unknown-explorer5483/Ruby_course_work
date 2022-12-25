module RoomsHelper
    def self.get_not_booked_dates_in_month(room, date)
        start_date = Date.today == date ? Date.today + 1.day : date.beginning_of_month
        all_dates_current_month = start_date..date.end_of_month
        booked_dates_current_month = Booking.where(room:).map(&:date)
        all_dates_current_month.reject { |date_elem| booked_dates_current_month.include? date_elem }
      end
    
      def self.generate_date_json(allowed_dates_current_month, allowed_dates_next_month)
        { currentMonth: current_month(allowed_dates_current_month), nextMonth: next_month(allowed_dates_next_month) }
      end
    
      def self.current_month(allowed_dates_current_month)
        {
          name: Date::ABBR_MONTHNAMES[Date.today.month], dayCount: Date.today.end_of_month.day,
          firstDayInMonth: Date.today.beginning_of_month.cwday, allowedDates: allowed_dates_current_month
        }
      end
    
      def self.next_month(allowed_dates_next_month)
        {
          name: Date::ABBR_MONTHNAMES[Date.today.next_month.month], dayCount: Date.today.next_month.end_of_month.day,
          firstDayInMonth: Date.today.next_month.beginning_of_month.cwday, allowedDates: allowed_dates_next_month
        }
    end
end
