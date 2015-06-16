class EntriesController < ApplicationController
  include ActionView::Helpers::SanitizeHelper

  before_filter :user
  before_filter :gitlab_access_configured!

  def index
    @entry = Entry.new
    load_last_entries
  end

  def create
    @entry = Entry.new date: entry_params[:date],
                      user: current_user,
                      duration: entry_params[:duration].to_f,
                      activity_id: entry_params[:activity].to_i,
                      group: entry_params[:group].to_i,
                      description: entry_params[:description].to_s

    @entry.project = params[:entry][:project].to_i if params[:entry][:project]
    @entry.issue = params[:entry][:issue].to_i if params[:entry][:issue]

    if @entry.valid?
      @entry.save()
      redirect_to entries_path
    else
      flash[:alert] = @entry.errors.full_messages.join(' ')
      load_last_entries
      render :index
    end
  end

  def import_index
    render :import
  end

  def import_data
    processed = Entry.import(params[:file], current_user)

    puts processed

    if processed.nil?
      redirect_to entries_url, :alert => t('entries.alerts.bad_file')
    elsif processed[:skipped] > 0
      redirect_to entries_url, :alert => t('entries.alerts.many_errors_during_import', count: processed[:skipped])
    else
      redirect_to entries_url, :notice => t('notices.successfully_imported')
    end
  end

  def destroy
    @entry = Entry.find(params[:id])
    @entry.destroy

    redirect_to entries_url, notice: t('notices.successfully_deleted')
  end

  private

  def load_last_entries
    @entries_for_today = @user.entries.where(:date => Date.today)
    @entries_for_yesterday = @user.entries.where(:date => Date.yesterday)
    @entries_for_week = @user.entries.where(:date => Date.today.beginning_of_week..Date.today)
    @entries = @user.entries.where('date < ?', Date.today.beginning_of_week)
  end

  def user
    @user = current_user
  end

  def entry_params
    params.require('entry').permit(:date, :duration, :activity, :group, :description, :project, :issue);
  end
end