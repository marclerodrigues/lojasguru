require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  describe 'GET #index' do
    let(:category){FactoryGirl.create(:category)}

    before :each do
      get :index
    end

    it 'return status 200' do
      expect(response).to be_success
    end

    it 'render index template' do
      expect(response).to render_template :index
    end

    it 'assigns all categories as @categories' do
      expect(assigns(:categories)).to eq([category])
    end
  end

  describe 'GET #show' do
    let(:category){FactoryGirl.create(:category)}

    before :each do
      get :show, id: category.id
    end

    it 'return status 200' do
      expect(response).to be_success
    end

    it 'render show template' do
      expect(response).to render_template :show
    end

    it 'assigns category as @category' do
      expect(assigns(:category)).to eq(category)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      let(:category){FactoryGirl.attributes_for(:category)}

      it 'creates a new category' do
        expect {
          post :create, category: category
        }.to change(Category, :count).by(1)
      end

      it 'redirect to the new category' do
        post :create, category: category
        expect(response).to redirect_to Category.last
      end
    end

    context 'with invalid attributes' do
      let(:category){FactoryGirl.attributes_for(:category, name: nil)}

      it 'does not save the category' do
        expect {
          post :create, category: category
        }.not_to change(Category, :count)
      end

      it 're-render :new template' do
        post :create, category: category
        expect(response).to render_template :new
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid attributes' do
      let(:category){FactoryGirl.create(:category)}

      before :each do
        put :update, id: category, category: FactoryGirl.attributes_for(:category, name: 'Test')
      end

      it 'assigns category to @category' do
        expect(assigns(:category)).to eq(category)
      end

      it 'change category attributes' do
        category.reload
        expect(category.name).to eq('Test')
      end

      it 'redirect to category' do
        expect(response).to redirect_to category
      end
    end

    context 'with invalid attributes' do
      let(:category){FactoryGirl.create(:category, name: 'Spec')}

      before :each do
        put :update, id: category, category: FactoryGirl.attributes_for(:category, name: nil)
      end

      it 'assigns category to @category' do
        expect(assigns(:category)).to eq(category)
      end

      it 'does not change category attributes' do
        category.reload
        expect(category.name).to eq('Spec')
      end

      it 're-render :edit template' do
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    before :each do
      @category = FactoryGirl.create(:category)
    end

    it 'deletes category' do
      expect {
        delete :destroy, id: @category
        }.to change(Category, :count).by(-1)
    end

    it 'redirect to :index' do
      delete :destroy, id: @category
      expect(response).to redirect_to categories_path
    end
  end
end
