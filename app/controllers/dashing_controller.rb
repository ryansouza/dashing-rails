class DashingController < ActionController::Base
  layout nil

  def index
    respond_to do |t|
      t.html
    end
  end

  def events
    response.headers['Content-Type'] = 'text/event-stream;charset=utf-8'

    out = []

    out << "retry: 1000\n\n"

    Dashing.histories.each do |id,event|
      out << "data: #{event.to_json}\n\n"
    end

    render text: out.join("")
  end

  def dashboard
    respond_to do |t|
      t.html { render file: dashboard_path, layout: "dashboard" }
    end
  rescue ActionView::MissingTemplate => e
    raise "Could not find dashboard '#{params[:dashboard]}' in #{Dashing.app_dashing_path}/dashboards"
  end

  def widget
    respond_to do |t|
      t.html { render file: widget_path }
    end
  rescue ActionView::MissingTemplate => e
    raise "Could not find widget '#{params[:widget]}' in #{Dashing.app_dashing_path}/widgets"
  end

  private

  def widget_path
    widget = params[:widget]

    unless widget =~ /\A[a-zA-z0-9_\-]+\z/
      raise ActionController::RoutingError, <<-ERROR
        Invalid widget name '#{params[:widget]}'.
        Must contain only alphanumerics, underscores, and dashes
      ERROR
    end

    "#{Rails.root}/app/dashboard/widgets/#{widget}/#{widget}"
  end

  def dashboard_path
    dashboard = params[:dashboard]

    unless dashboard =~ /\A[a-zA-z0-9_\-]+\z/
      raise ActionController::RoutingError, <<-ERROR
        Invalid dashboard name '#{params[:dashboard]}'.
        Must contain only alphanumerics, underscores, and dashes
      ERROR
    end

    "#{Rails.root}/app/dashboard/dashboards/#{dashboard}"
  end

end
