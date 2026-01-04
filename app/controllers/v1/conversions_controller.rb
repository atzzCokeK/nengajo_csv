# frozen_string_literal: true

require "csv"

module V1
    class ConversionsController < ApplicationController
        def preview
            uploaded = params[:file]
            return render json: { error: "No file uploaded" }, status: :unprocessable_entity if uploaded.blank?

            headers = CSV.open(uploaded.tempfile.path, "r:bom|utf-8", headers: true) do |csv|
                csv.first&.headers
            end

            return render json: { error: "could not read headers from file" }, status: :unprocessable_entity if headers.blank?

            render json: { headers: headers }

        rescue CSV::MalformedCSVError => e
            render json: { error: "could not read file", details: e.message }, status: :unprocessable_entity
        end
    end
end
