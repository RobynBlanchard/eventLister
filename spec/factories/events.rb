require 'rails_helper'
require 'spec_helper'

FactoryBot.define do

  # event factory with a `belongs_to` association for the user
  factory :event do
    artist
    event_title "event title"
    location "event location"
  end

  # user factory without associated posts
  factory :artist do
    name "Jackmaster"
    url "https://www.residentadvisor.net/dj/jackmaster/dates?ctry=3"

    # artist_with_events will create event data after the artist has been created
    factory :artist_with_events do
      # events_count is declared as a transient attribute and available in
      # attributes on the factory, as well as the callback via the evaluator
      transient do
        posts_count 5
      end

      # the after(:create) yields two values; the artist instance itself and the
      # evaluator, which stores all values from the factory, including transient
      # attributes; `create_list`'s second argument is the number of records
      # to create and we make sure the artist is associated properly to the event
      after(:create) do |user, evaluator|
        create_list(:event, evaluator.posts_count, artist: artist)
      end
    end
  end
end
