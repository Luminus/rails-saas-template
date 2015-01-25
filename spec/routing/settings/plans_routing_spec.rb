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

# Tests for settings/plans routing
RSpec.describe 'routing for the settings plans', type: :routing do
  it 'routes GET /path/settings/plan to settings/plans#show' do
    expect(get: '/path/settings/plan').to route_to(
      controller: 'settings/plans',
      action: 'show',
      path: 'path'
    )
  end

  it 'routes GET /path/settings/plan/1 to settings/plans#edit' do
    expect(get: '/path/settings/plan/1').to route_to(
      controller: 'settings/plans',
      action: 'edit',
      id: '1',
      path: 'path'
    )
  end

  it 'routes PATCH /path/settings/plan to settings/plans#update' do
    expect(patch: '/path/settings/plan').to route_to(
      controller: 'settings/plans',
      action: 'update',
      path: 'path'
    )
  end

  it 'routes DELETE /path/settings/plan to settings/plans#destroy' do
    expect(delete: '/path/settings/plan').to route_to(
      controller: 'settings/plans',
      action: 'destroy',
      path: 'path'
    )
  end

  it 'routes GET /path/settings/plan/cancel to settings/plans#cancel' do
    expect(get: '/path/settings/plan/cancel').to route_to(
      controller: 'settings/plans',
      action: 'cancel',
      path: 'path'
    )
  end

  it 'routes PATCH /path/settings/plans/pause to settings/plans#pause' do
    expect(patch: '/path/settings/plan/pause').to route_to(
      controller: 'settings/plans',
      action: 'pause',
      path: 'path'
    )
  end
end
