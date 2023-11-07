class Admin::DashboardsController < Admin::BaseController
  def index
    @main_chart_data = get_main_chart_data(7)
    @top_movies = get_top_movies(5, 7)
    @top_customers = get_top_customers(5, 7)
    @new_customers_chart_data = get_new_customers_chart_data(30)
    @new_tickets_chart_data = get_new_tickets_chart_data(30)
  end

  def update_main_chart
    @main_chart_data = get_main_chart_data(params[:period].to_i)
    respond_to do |format|
      format.json do
        render json: { main_chart_data: @main_chart_data }
      end
    end
  end

  def update_stats
    @top_movies = get_top_movies(5, params[:period].to_i)
    @top_customers = get_top_customers(5, params[:period].to_i)

    respond_to do |format|
      format.json do
        render json: { top_movies_html: render_to_string(partial: 'admin/dashboards/top_movies',
                                                         locals: { top_movies: @top_movies }, layout: false, formats: [:html]),
                       top_customers_html: render_to_string(partial: 'admin/dashboards/top_customers',
                                                            locals: { top_customers: @top_customers }, layout: false, formats: [:html]) }
      end
    end
  end

  private

  def get_main_chart_data(period)
    main_chart_data = {}

    current_main_chart_data = Ticket.order('date(created_at) ASC').group('date(created_at)').where(created_at: (Time.current - period.days)..).sum(:price)

    total_revenue = Ticket.where(created_at: (Time.current - period.days)..).sum(:price)
    main_chart_data[:current_main_chart_data] = current_main_chart_data
    main_chart_data[:total_revenue] = total_revenue

    main_chart_data
  end

  def get_top_movies(number, period)
    Movie.joins(showtimes: :tickets)
         .select('movies.*, SUM(tickets.price) as total_price')
         .where(tickets: { created_at: (Time.current - period.days).. })
         .group('movies.id')
         .order('total_price DESC')
         .limit(number)
  end

  def get_top_customers(number, period)
    User.joins(:tickets)
        .select('users.*, SUM(tickets.price) as total_price')
        .where(tickets: { created_at: (Time.current - period.days).. })
        .group('users.id')
        .order('total_price DESC')
        .limit(number)
  end

  def get_new_customers_chart_data(period)
    new_customers_chart_data = {}

    current_data = User.order('date(created_at) ASC').group('date(created_at)').where(created_at: (Time.current - period.days)..).count(:id)
    total_new_users = User.order('date(created_at) ASC').where(created_at: (Time.current - period.days)..).count
    new_customers_chart_data[:current_data] = current_data
    new_customers_chart_data[:total_new_users] = total_new_users

    new_customers_chart_data
  end

  def get_new_tickets_chart_data(period)
    new_tickets_chart_data = {}

    current_data = Ticket.order('date(created_at) ASC').group('date(created_at)').where(created_at: (Time.current - period.days)..).count(:id)
    total_new_tickets = Ticket.order('date(created_at) ASC').where(created_at: (Time.current - period.days)..).count
    new_tickets_chart_data[:current_data] = current_data
    new_tickets_chart_data[:total_new_tickets] = total_new_tickets

    new_tickets_chart_data
  end
end
