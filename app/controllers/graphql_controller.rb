# frozen_string_literal: true

# This controller handles GraphQL queries and mutations.
# It serves as the entry point for GraphQL requests.
# The controller processes incoming GraphQL queries or mutations, prepares the necessary variables,
# and executes them using the defined GraphQL schema (GraphqlLabSchema).
class GraphqlController < ApplicationController
  # Uncomment the line below to nullify the session for external API access.
  # This prevents CSRF attacks but requires separate user authentication.
  # protect_from_forgery with: :null_session

  # Main action to handle GraphQL requests.
  # This action accepts the query, variables, and operation name as parameters,
  # prepares the necessary context, and executes the GraphQL query/mutation.
  def execute
    variables = prepare_variables(params[:variables])
    query = params[:query]
    operation_name = params[:operationName]
    context = {
      # Add any necessary context here. For example, you might include:
      # current_user: current_user, to authenticate or personalize the query.
    }

    # Execute the GraphQL query/mutation and render the result as JSON.
    result = GraphqlLabSchema.execute(query, variables: variables, context: context, operation_name: operation_name)
    render json: result
  rescue StandardError => e
    # In development, provide detailed error messages.
    raise e unless Rails.env.development?

    handle_error_in_development(e)
  end

  private

  # Prepares variables for the GraphQL query.
  # This method processes variables from different formats: JSON strings, Hashes, Parameters, or blank values.
  #
  # @param variables_param [String, Hash, ActionController::Parameters, nil] The variables sent with the GraphQL request
  # @return [Hash] A Hash representation of the variables.
  def prepare_variables(variables_param)
    case variables_param
    when String
      if variables_param.present?
        JSON.parse(variables_param) || {}
      else
        {}
      end
    when Hash
      variables_param
    when ActionController::Parameters
      # Convert parameters to a hash, relying on GraphQL-Ruby to validate their names and types.
      variables_param.to_unsafe_hash
    when nil
      {}
    else
      # Raise an error if the variable format is unexpected.
      raise ArgumentError, "Unexpected parameter: #{variables_param}"
    end
  end

  # Handles errors that occur during development.
  # This method logs the error details and returns them in the response for easier debugging.
  #
  # @param error [StandardError] The error raised during execution.
  def handle_error_in_development(error)
    logger.error error.message
    logger.error error.backtrace.join("\n")

    render json: { errors: [{ message: error.message, backtrace: error.backtrace }], data: {} }, status: 500
  end
end
