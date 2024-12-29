# frozen_string_literal: true

# The Queryable module provides flexible filtering for ActiveRecord models, allowing
# users to filter by attributes or associations without explicitly specifying the model class.
# This module includes a scope, `where_matches_any`, which can be used to apply
# dynamic, chainable filters to both direct model attributes and associated records.
#
#
# This module enhances the readability and maintainability of complex queries,
# allowing easy chaining and reuse of query filters.
module Queryable
  extend ActiveSupport::Concern

  included do
    #
    #
    #
    # Scope to apply dynamic filters by attributes or associations on the model.
    # Accepts an options hash specifying the filters.
    #
    # @param options [Hash] A hash defining the filters to apply. Can include direct
    # attributes or nested association filters.
    #
    # @example Filtering by a direct attribute
    #   User.where_matches_any(name: 'John')
    #
    # @example Filtering by an association attribute
    #   User.where_matches_any(association: { role: { name: 'admin' } })
    #
    scope :where_matches_any, lambda { |options|
      build_query(self, options)
    }
  end

  class_methods do
    #
    #
    #
    # Constructs a query based on the given options, which can specify filters
    # for both model attributes and associations.
    #
    # @param model_class [Class] The ActiveRecord model class the query applies to.
    # @param options [Hash] Specifies filters with keys for :attribute or :association.
    # @return [ActiveRecord::Relation] The constructed query with applied filters.
    #
    def build_query(model_class, options)
      query = model_class.all
      options.each do |key, value|
        if key == :association
          # Processes association filters
          value.each do |assoc_name, assoc_attrs|
            query = apply_association_filters(query, assoc_name, assoc_attrs)
          end
        else
          # Processes direct model attribute filters
          query = apply_attribute_filters(query, { key => value })
        end
      end
      query
    end

    #
    #
    #
    # Applies filters directly to model attributes.
    #
    # @param query [ActiveRecord::Relation] The initial query to apply filters on.
    # @param attrs [Hash] Hash of attribute filters with field names as keys.
    # @return [ActiveRecord::Relation] The query with applied attribute filters.
    #
    def apply_attribute_filters(query, attrs)
      attrs.each do |attribute, value|
        # Converts `value` to an array with each element wrapped in `%...%` for pattern matching
        value = Array(value).map { |v| "%#{v}%" }

        # Uses `attribute` to dynamically match the correct model column for filtering
        query = query.where(query.arel_table[attribute].matches_any(value))
      end
      query
    end

    #
    #
    #
    # Applies filters to associated models by joining the association and adding
    # filtering conditions.
    #
    # @param query [ActiveRecord::Relation] The initial query to apply filters on.
    # @param assoc_name [Symbol] The association name to filter.
    # @param assoc_attrs [Hash] Hash of attribute filters within the associated model.
    # @return [ActiveRecord::Relation] The query with applied association filters.
    #
    def apply_association_filters(query, assoc_name, assoc_attrs)
      association = query.reflect_on_association(assoc_name.to_sym)
      return query.none unless association

      assoc_attrs.each do |attribute, value|
        value = Array(value).map { |v| "%#{v}%" }
        query = query.joins(assoc_name.to_sym)
                     .where("#{association.klass.table_name}.#{attribute} ILIKE ANY (array[?])", value)
      end
      query
    end
  end
end
