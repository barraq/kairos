class EntriesController < ApplicationController
  include ActionView::Helpers::SanitizeHelper

  before_filter :user
  before_filter :gitlab_access_configured!

  def index
    @entries_for_today = @user.entries.where(:date => Date.today)
    @entries_for_yesterday = @user.entries.where(:date => Date.yesterday)
    @entries_for_week = @user.entries.where(:date => Date.today.beginning_of_week..Date.today)
    @entries = @user.entries.where('date < ?', Date.today.beginning_of_week)
  end

  def create
    entry = Entry.new date: Date.strptime(entry_params[:date], '%d/%m/%Y').strftime("%Y-%m-%d"),
                      user: current_user,
                      duration: entry_params[:duration].to_f,
                      activity_id: entry_params[:activity].to_i,
                      group: entry_params[:group].to_i

    entry.project = params[:project].to_i if params[:project]
    entry.issue = params[:issue].to_i if params[:issue]

    if entry.valid?
      entry.save()
    else
      flash[:notice] = entry.errors.full_messages.join(' ')
    end

    redirect_to entries_path
  end

  def destroy
    @entry = Entry.find(params[:id])
    @entry.destroy

    redirect_to entries_url, notice: t('notices.successfully_deleted')
  end

  private

  def user
    @user = current_user
  end

  def entry_params
    params.permit(:date, :duration, :activity, :group, :project, :issue);
  end
end