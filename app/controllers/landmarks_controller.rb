class LandmarksController < ApplicationController

  get '/landmarks' do
    @landmarks = Landmark.all
    erb :'/landmarks/index'
  end

  get '/landmarks/new' do
    @landmarks = Landmark.all
    erb :'landmarks/new'
  end

  get '/landmarks/:id' do
    @landmark = Landmark.find_by(id: params[:id])
    #@landmark.inspect
    erb :'landmarks/show'
  end

  get '/landmarks/:id/edit' do
    @landmark = Landmark.find_by(id: params[:id])
    erb :'landmarks/edit'
  end

  patch '/landmarks/:id' do
    @landmark = Landmark.find_by(id: params[:id])
    @landmark.update(name: params[:landmark][:name], year_completed: params[:landmark][:year_completed])
    redirect "landmarks/#{@landmark.id}"
  end

  post '/landmarks' do
    Landmark.create(name: params[:name], year_completed: params[:year_completed])
    redirect '/landmarks'
  end
end
