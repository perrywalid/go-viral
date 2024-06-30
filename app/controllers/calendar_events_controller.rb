class CalendarEventsController < ApplicationController
  def index
    calendar_events = CalendarEventResource.all(params)
    respond_with(calendar_events)
  end

  def show
    calendar_event = CalendarEventResource.find(params)
    respond_with(calendar_event)
  end

  def create
    calendar_event = CalendarEventResource.build(params)

    if calendar_event.save
      render jsonapi: calendar_event, status: 201
    else
      render jsonapi_errors: calendar_event
    end
  end

  def update
    calendar_event = CalendarEventResource.find(params)

    if calendar_event.update_attributes
      render jsonapi: calendar_event
    else
      render jsonapi_errors: calendar_event
    end
  end

  def destroy
    calendar_event = CalendarEventResource.find(params)

    if calendar_event.destroy
      render jsonapi: { meta: {} }, status: 200
    else
      render jsonapi_errors: calendar_event
    end
  end
end
