class GroupsController < ApplicationController

  def index
    @book = Book.new
    @groups = Group.all
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    @group.users << current_user
    if @group.save
      redirect_to groups_path
    else
      render "new"
    end
  end

  def show
    @group = Group.find(params[:id])
    @book =Book.new
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to groups_path
    else
      render "edit"
    end
  end

  def destroy
    @group = Group.find(params[:id])
    @group.users.delete(current_user)
    redirect_to groups_path
  end

  def join
    @group = Group.find(params[:group_id])
    @group.users << current_user
    redirect_to groups_path
  end

  def new_mail
    @group = Group.find(params[:group_id])
  end

  def send_mail
    @group = Group.find(params[:group_id])
    group_users = @group.users
    @mail_title = params[:mail_title]
    @mail_content = params[:mail_content]
    ContactMailer.send_mail(@mail_titile, @mail_content, group_users).deliver
  end

  def group_params
    params.require(:group).permit(:name, :introduction, :image)
  end
end
