# frozen_string_literal: true

# The Filterable module provides a reusable mechanism for dynamically applying
# filters to ActiveRecord queries based on a set of filtering parameters.
module Filterable
  extend ActiveSupport::Concern

  # Class methods to be added when including this module
  module ClassMethods
    #
    #
    # Applies dynamic filters based on the given filtering_params.
    # For each key in filtering_params, attempts to call a corresponding scope
    # named `filter_by_<key>`, passing `value` as the parameter.
    #
    # @param filtering_params [Hash] A hash of filter parameters, where each key
    #   represents the filter name and each value is the value to filter by.
    # @return [ActiveRecord::Relation] The filtered result set.
    #
    def filter_by(filtering_params)
      results = all
      filtering_params.each do |key, value|
        # Clean up the value: if it's an array, remove blank values; otherwise, strip it.
        value = value.is_a?(Array) ? value.compact_blank : value&.strip
        next if value.blank? # Skip if value is now empty or nil

        # Call the corresponding scope dynamically, e.g., `filter_by_name`
        results = results.public_send("filter_by_#{key}", value)
      end
      results
    end
  end
end
