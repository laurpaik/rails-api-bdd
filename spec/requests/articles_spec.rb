# frozen_string_literal: true
require 'rails_helper'

# calls the method describe on the Rspec class
# passes a string to describe what we're going to test
RSpec.describe 'Articles API' do
  # defines an article params method that returns an object
  # with a title and content
  def article_params
    {
      title: 'One Weird Trick',
      content: 'You won\'t believe what happens next...'
    }
  end

  # defines a function articles that returns all the articles
  def articles
    Article.all
  end

  # returns the first article
  # Article is a model class
  def article
    Article.first
  end

  # all refers to the test
  # before you run the test, create an Article called article_params
  before(:all) do
    Article.create!(article_params)
  end

  # after running the test, delete all the Articles?
  after(:all) do
    Article.delete_all
  end

  # describe a GET request to /articles
  describe 'GET /articles' do
    # a GET request to /articles should list all the articles
    it 'lists all articles' do
      # mocks a get request... makes a GET request to your API to /articles
      get '/articles'
      # I expect the response to be 2xx
      expect(response).to be_success
      # parses the JSON response into a ruby array so we can test it
      articles_response = JSON.parse(response.body)
      # expects the length of the response to be the same as the number of
      # articles in the database
      expect(articles_response.length).to eq(articles.count)
      # expects the first article in the response to be the
      # first article in the database
      expect(articles_response.first['title']).to eq(article['title'])
    end
  end

  describe 'GET /articles/:id' do
    skip 'shows one article' do
    end
  end

  describe 'DELETE /articles/:id' do
    skip 'deletes an article' do
    end
  end

  describe 'PATCH /articles/:id' do
    def article_diff
      { title: 'Two Stupid Tricks' }
    end

    skip 'updates an article' do
    end
  end

  describe 'POST /articles' do
    skip 'creates an article' do
    end
  end
end
