# Encoding: utf-8

# Copyright (c) 2014-2015, Richard Buggy <rich@buggy.id.au>
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

require 'rails_helper'

# Tests for admin/users routing
RSpec.describe 'routing for the admin users', type: :routing do
  it 'routes GET /admin/users to admin/users#index' do
    expect(get: '/admin/users').to route_to(
      controller: 'admin/users',
      action: 'index'
    )
  end

  it 'routes GET /admin/users/1 to admin/users#show' do
    expect(get: '/admin/users/1').to route_to(
      controller: 'admin/users',
      action: 'show',
      id: '1'
    )
  end

  it 'routes GET /admin/users/1/accounts to admin/users#accounts' do
    expect(get: '/admin/users/1/accounts').to route_to(
      controller: 'admin/users',
      action: 'accounts',
      user_id: '1'
    )
  end

  it 'routes GET /admin/users/1/edit to admin/users#edit' do
    expect(get: '/admin/users/1/edit').to route_to(
      controller: 'admin/users',
      action: 'edit',
      id: '1'
    )
  end

  it 'routes GET /admin/users/new to admin/users#new' do
    expect(get: '/admin/users/new').to route_to(
      controller: 'admin/users',
      action: 'new'
    )
  end

  it 'routes PATCH /admin/users/1 to admin/users#update' do
    expect(patch: '/admin/users/1').to route_to(
      controller: 'admin/users',
      action: 'update',
      id: '1'
    )
  end

  it 'routes POST /admin/users to admin/users#create' do
    expect(post: '/admin/users').to route_to(
      controller: 'admin/users',
      action: 'create'
    )
  end

  it 'routes GET /admin/users/1/user_invitations to admin/users#user_invitations' do
    expect(get: '/admin/users/1/user_invitations').to route_to(
      controller: 'admin/users',
      action: 'user_invitations',
      user_id: '1'
    )
  end
end
