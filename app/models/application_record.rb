# frozen_string_literal: true

# The ApplicationRecord class serves as the base class for all models in the application.
# It inherits from ActiveRecord::Base and is marked as an abstract class.
# This means it is not associated with any specific database table and is used only for inheritance purposes.
#
# By defining common functionality, validations, or scopes here, all models in the application
# will inherit those behaviors automatically, promoting reusability and consistency.
#
# Examples of common functionality that can be added to ApplicationRecord:
# - Custom scopes
# - Shared validation methods
# - Utility methods for all models
class ApplicationRecord < ActiveRecord::Base
  # Marks this class as abstract, meaning it will not map directly to a database table.
  self.abstract_class = true
end
