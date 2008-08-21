require 'test_helper'

class DogsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:dogs)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_dog
    assert_difference('Dog.count') do
      post :create, :dog => { }
    end

    assert_redirected_to dog_path(assigns(:dog))
  end

  def test_should_show_dog
    get :show, :id => dogs(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => dogs(:one).id
    assert_response :success
  end

  def test_should_update_dog
    put :update, :id => dogs(:one).id, :dog => { }
    assert_redirected_to dog_path(assigns(:dog))
  end

  def test_should_destroy_dog
    assert_difference('Dog.count', -1) do
      delete :destroy, :id => dogs(:one).id
    end

    assert_redirected_to dogs_path
  end
end
