class TweetsController < ApplicationController
  before_action :set_tweet, only: [:show, :edit, :update, :destroy]

  # GET /tweets
  # GET /tweets.json
  def index
    @tweets = Tweet.all.order("id DESC")
    if params[:page] and params[:page].to_i > 0
      @tweets = @tweets.limit(params[:page].to_i*5) - @tweets.limit((params[:page].to_i*5)-5)
    end
    respond_to do |format|
      format.html
      format.json { render json: @tweets.to_json, :content_type => 'application/json' }
      format.xml { render xml: @tweets.to_xml, :content_type => 'text/xml' }
      format.yaml { render text: @tweets.to_yaml, :content_type => 'text/yaml' }
    end
  end

  # GET /tweets/1
  # GET /tweets/1.json
  def show
    respond_to do |format|
      format.html
      format.json { render json: @tweet.to_json, :content_type => 'application/json' }
      format.xml { render xml: @tweet.to_xml, :content_type => 'text/xml' }
      format.yaml { render text: @tweet.to_yaml, :content_type => 'text/yaml' }
    end
  end

  # GET /tweets/new
  def new
    @tweet = Tweet.new
  end

  # GET /tweets/1/edit
  def edit
  end

  # POST /tweets
  # POST /tweets.json
  def create
    @tweet = Tweet.new(tweet_params)

    respond_to do |format|
      if @tweet.save
        format.html { redirect_to @tweet, notice: 'Tweet was successfully created.' }
        format.json { render json: ok_msg.to_json, :content_type => 'application/json' }
        format.xml { render xml: {'status' => 'OK'}.to_xml(:root => 'response'), :content_type => 'text/xml' }
        format.yaml { render text: ok_msg.to_yaml, :content_type => 'text/yaml' }
      else
        format.html { render action: 'new' }
        format.json { render json: error_msg.to_json, :content_type => 'application/json' }
        format.xml { render xml: {'status' => 'ERROR'}.to_xml(:root => 'response'), :content_type => 'text/xml' }
        format.yaml { render text: error_msg.to_yaml, :content_type => 'text/yaml' }
      end
    end
  end

  # PATCH/PUT /tweets/1
  # PATCH/PUT /tweets/1.json
  def update
    respond_to do |format|
      if @tweet.update(tweet_params)
        format.html { redirect_to @tweet, notice: 'Tweet was successfully updated.' }
        format.json { render json: ok_msg.to_json, :content_type => 'application/json' }
        format.xml { render xml: {'status' => 'OK'}.to_xml(:root => 'response'), :content_type => 'text/xml' }
        format.yaml { render text: ok_msg.to_yaml, :content_type => 'text/yaml' }
      else
        format.html { render action: 'edit' }
        format.json { render json: error_msg.to_json, :content_type => 'application/json' }
        format.xml { render xml: {'status' => 'ERROR'}.to_xml(:root => 'response'), :content_type => 'text/xml' }
        format.yaml { render text: error_msg.to_yaml, :content_type => 'text/yaml' }
      end
    end
  end

  # DELETE /tweets/1
  # DELETE /tweets/1.json
  def destroy
    respond_to do |format|
      if @tweet.destroy
        format.html { redirect_to tweets_url }
        format.json { render json: ok_msg.to_json, :content_type => 'application/json' }
        format.xml { render xml: {'status' => 'OK'}.to_xml(:root => 'response'), :content_type => 'text/xml' }
        format.yaml { render text: ok_msg.to_yaml, :content_type => 'text/yaml' }
      else
        format.html { redirect_to tweets_url }
        format.json { render json: error_msg.to_json, :content_type => 'application/json' }
        format.xml { render xml: {'status' => 'ERROR'}.to_xml(:root => 'response'), :content_type => 'text/xml' }
        format.yaml { render text: error_msg.to_yaml, :content_type => 'text/yaml' }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tweet_params
      params.require(:tweet).permit(:username, :content)
    end

    def ok_msg
      ok = { 'response' => {'status' => 'OK'} }
    end

    def error_msg
      error = { 'response' => {'status' => 'ERROR'} }
    end

end
