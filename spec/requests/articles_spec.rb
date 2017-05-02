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
    # FEATURE TEST
    it 'shows one article' do
      get "/articles/#{article.id}"

      expect(response).to be_success

      article_response = JSON.parse(response.body)

      expect(article_response['id']).to eq(article['id'])
      expect(article_response['title']).to eq(article['title'])
    end
  end

  describe 'DELETE /articles/:id' do
    it 'deletes an article' do
      article_id = article.id
      delete "/articles/#{article.id}"

      expect(response).to be_success
      expect(response.body).to be_empty
      expect { Article.find(article_id) }
        .to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe 'PATCH /articles/:id' do
    def article_diff
      { title: 'Two Stupid Tricks' }
    end

    it 'updates an article' do
      patch "/articles/#{article.id}", params: { article: article_diff }

      expect(response).to be_success

      expect(article[:title]).to eq(article_diff[:title])
    end
  end

  describe 'POST /articles' do
    it 'creates an article' do
      def article_new
        {
          title: 'Never Gonna',
          content: 'Give You Up'
        }
      end

      post '/articles', params: { article: article_new }

      expect(response).to be_success

      article_response = JSON.parse(response.body)
      expect(article_response['title']).to eq(article_new['title'])
      expect(article_response['id']).to_not be_nil
    end
  end
end
