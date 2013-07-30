class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
      user ||= User.new # guest user (not logged in)
      if user.admin?
        can :manage, :all
      else
        can :read, SchoolDay do |school_day|
          school_day.calendar_date <= Date.today
        end
        can [:read], SchoolDay do |school_day|
          school_day.calendar_date <= Date.today
        end
        can [:read], Lecture do |lecture|
          lecture.school_days.sort_by{|school_day| school_day.calendar_date}[0].calendar_date <= Date.today
        end
        can [:read], Todo do |todo|
          todo.school_days.sort_by{|school_day| school_day.calendar_date}[0].calendar_date <= Date.today
        end
        can [:read], Potd do |potd|
          potd.school_days.sort_by{|school_day| school_day.calendar_date}[0].calendar_date <= Date.today
        end
        can [:read], Lab do |lab|
          lab.school_days.sort_by{|school_day| school_day.calendar_date}[0].calendar_date <= Date.today
        end
        can [:read], Link do |link|
          link.school_days.sort_by{|school_day| school_day.calendar_date}[0].calendar_date <= Date.today
        end
        can [:read], Homework do |homework|
          homework.school_days.sort_by{|school_day| school_day.calendar_date}[0].calendar_date <= Date.today
        end

        can :create, Comment
        can :update, Comment do |comment|
          comment && comment.user == user
        end
        cannot :index, User
        cannot :assign_role, User
        can [:show, :edit, :update], User do |current_user|
          user.id == current_user.id || user.role == "admin"
        end
      end
    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
