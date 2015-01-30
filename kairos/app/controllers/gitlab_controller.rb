class GitlabController < ApplicationController

  before_filter :user
  before_filter :gitlab_access_configured!

  layout false

  def groups
    # request some information from Gitlab
    client = Gitlab.client(endpoint: Settings.gitlab.server_url + '/api/v3/', private_token: @user.gitlab_token, httparty: {verify: false})
    @groups = client.groups

    render json: @groups
  end

  def project
    # request some information from Gitlab
    client = Gitlab.client(endpoint: Settings.gitlab.server_url + '/api/v3/', private_token: @user.gitlab_token, httparty: {verify: false})
    @project = client.projects(params[:id])

    render json: @project
  end

  def projects
    # request some information from Gitlab
    client = Gitlab.client(endpoint: Settings.gitlab.server_url + '/api/v3/', private_token: @user.gitlab_token, httparty: {verify: false})
    @projects = client.projects

    render json: @projects
  end

  def issues_for_project
    # request some information from Gitlab
    client = Gitlab.client(endpoint: Settings.gitlab.server_url + '/api/v3/', private_token: @user.gitlab_token, httparty: {verify: false})
    @issues = client.issues(project=params[:id])

    render json: @issues
  end

  private

  def user
    @user = current_user
  end
end
