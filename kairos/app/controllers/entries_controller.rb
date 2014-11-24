module Api
  module V1
    class EntriesController < ApplicationController
      respond_to :json

      before_action :authenticate_user!

      def create
        puts params
      end

      def for_user
        puts params[:date], params[:id]
        respond_with Entry.all
      end

      def for_group

      end

      def for_project

      end

      def for_issue

      end
    end
  end
end