# Encoding: utf-8

# Copyright (c) 2014, Richard Buggy
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
# 1. Redistributions of source code must retain the above copyright notice, this
#    list of conditions and the following disclaimer.
#
# 2. Redistributions in binary form must reproduce the above copyright notice,
#    this list of conditions and the following disclaimer in the documentation
#    and/or other materials provided with the distribution.
#
# 3. Neither the name of the copyright holder nor the names of its contributors
#    may be used to endorse or promote products derived from this software
#    without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
# CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
# OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

# The users abilities
class Ability
  include CanCan::Ability

  # rubocop:disable Metrics/CyclomaticComplexity, PerceivedComplexity
  def initialize(user, account, section)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
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
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
    return if user.nil?

    if account
      permissions = user.user_permissions.where(account: account).first
    else
      permissions = nil
    end

    # Super Admin's can do anything
    can :manage, :all if user.super_admin?

    # We really don't want people accessing these things via the admin if they can guess the URL
    unless section == :admin
      # Account Admin's get additional privileges
      if !permissions.nil? && permissions.account_admin?
        can :manage, Account, user_permissions: { user_id: user.id, account_admin: true }
        can :manage, UserInvitation, account: { user_permissions: { user_id: user.id, account_admin: true } }
        can :manage, UserPermission, account: { user_permissions: { user_id: user.id, account_admin: true } }
        can :manage, Invoice, account: { user_permissions: { user_id: user.id, account_admin: true } }
        can :index, :dashboard
      end

      # Regular users can do some things BUT not in the settings section
      unless section == :settings
        can :manage, User, id: user.id
        can :manage, UserPermission, user_id: user.id
      end
    end

    # Prevent the user from deleting themselves
    cannot :destroy, User, id: user.id

    # Prevent non-super admins from removing permissions involving themselves
    cannot :destroy, UserPermission, user_id: user.id unless user.super_admin

    # Enforce plan restrictions against everyone (including Super Admin's)
    cannot :pause, Account, plan: { paused_plan: nil }
  end
  # rubocop:enable Metrics/CyclomaticComplexity, PerceivedComplexity
end
