# frozen_string_literal: true
require 'rails_helper'

# unit tests
RSpec.describe 'routes for articles' do
  it 'routes GET /articles to the articles#index action' do
    # expects a get request to /articles to route to articles#index
    # route_to is a function that takes a string or a hash
    # the hash here tells the route where to look
    expect(get('/articles')).to route_to('articles#index')
  end

  it 'routes GET /articles/:id to the articles#show action' do
    expect(get('/articles/1')).to route_to(controller: 'articles',
                                           action: 'show',
                                           id: '1')
  end

  it 'routes DELETE /articles/:id to the articles#destroy action' do
    expect(delete('/articles/1')).to route_to(controller: 'articles',
                                              action: 'destroy',
                                              id: '1')
  end

  skip 'routes PATCH /articles/:id to the articles#update action' do
  end

  skip 'routes POST /articles to the articles#create action' do
  end
end
