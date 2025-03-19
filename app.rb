require 'sinatra/base'
require 'json'
require 'date'

module AppointmentScheduler
  # Simple in-memory storage for appointments
  class AppointmentStore
    class << self
      def appointments
        @appointments ||= []
      end

      def add(appointment)
        appointments << appointment
      end

      def all
        appointments
      end

      def exists?(details)
        appointments.any? do |appt|
          details.all? { |k, v| appt[k] == v }
        end
      end

      def clear
        @appointments = []
      end
    end
  end

  # Web application for appointment scheduling
  class App < Sinatra::Base
    set :views, File.join(File.dirname(__FILE__), 'views')
    enable :sessions

    get '/' do
      redirect to('/appointments')
    end

    # Appointment listing page
    get '/appointments' do
      @appointments = AppointmentStore.all
      erb :appointments
    end

    # New appointment form
    get '/appointments/new' do
      erb :new_appointment
    end

    # Create appointment
    post '/appointments' do
      appointment = {
        'date' => params[:appointment_date],
        'time' => params[:appointment_time],
        'description' => params[:appointment_description]
      }

      # Validate appointment (basic validation)
      if appointment['date'].empty? || appointment['time'].empty?
        session[:error] = "Date and time are required"
        redirect to('/appointments/new')
      end

      # Save appointment
      AppointmentStore.add(appointment)
      session[:notice] = "Appointment booked successfully"
      
      redirect to('/appointments')
    end
  end
end