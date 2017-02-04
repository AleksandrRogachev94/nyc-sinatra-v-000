class FiguresController < ApplicationController

  get '/figures' do
    @figures = Figure.all
    erb :'figures/index'
  end

  get '/figures/new' do
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'figures/new'
  end

  get '/figures/:id/edit' do
    @figure = Figure.find_by(id: params[:id])
    @landmarks_all = Landmark.all
    @landmarks = @figure.landmarks
    @titles_all = Title.all
    @titles = @figure.titles
    erb :'figures/edit'
  end

  patch '/figures/:id' do
    figure = Figure.find_by(id: params[:id])
    update_from_figures_page(figure, params)
    redirect "/figures/#{figure.id}"
  end

  get '/figures/:id' do
    @figure = Figure.find_by(id: params[:id])
    @landmarks = @figure.landmarks
    @titles = @figure.titles
    erb :'figures/show'
  end

  post '/figures' do
    create_from_figures_page(params)
    redirect '/figures'
  end

  helpers do
    def create_from_figures_page(params)

      figure = Figure.new(params[:figure])

      unless params[:landmark][:name].empty?
        landmark = Landmark.new(params[:landmark])
        figure.landmarks.concat(landmark)
      end


      unless params[:title][:name].empty?
        title = Title.new(params[:title])
        figure.titles.concat(title) #will not save because parent was not saved
      end

      figure.save
    end

    def update_from_figures_page(figure, params)

      figure.update(params[:figure])

      unless params[:landmark][:name].empty?
        landmark = Landmark.new(params[:landmark])
        figure.landmarks.concat(landmark)
      end


      unless params[:title][:name].empty?
        title = Title.new(params[:title])
        figure.titles.concat(title) #will not save because parent was not saved
      end

      figure.save
    end
  end
end
