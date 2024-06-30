# app/resources/calendar_event_resource.rb
class CalendarEventResource < ApplicationResource
  attribute :id, :integer, writable: false
  attribute :text, :string
  attribute :description, :string
  attribute :scheduled_for, :datetime
  attribute :user_id, :integer

  # Relationships
  belongs_to :user
end
