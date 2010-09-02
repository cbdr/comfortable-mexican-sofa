require  File.dirname(__FILE__) + '/../../test_helper'

class CmsAdmin::LayoutsControllerTest < ActionController::TestCase
  
  def test_get_index
    get :index
    assert_response :success
    assert assigns(:cms_layouts)
    assert_template :index
  end
  
  def test_get_new
    get :new
    assert_response :success
    assert assigns(:cms_layout)
    assert_template :new
    assert_select 'form[action=/cms-admin/layouts]'
  end
  
  def test_get_edit
    get :edit, :id => cms_layouts(:default)
    assert_response :success
    assert assigns(:cms_layout)
    assert_template :edit
    assert_select "form[action=/cms-admin/layouts/#{cms_layouts(:default).id}]"
  end
  
  def test_get_edit_failure
    get :edit, :id => 'not_found'
    assert_response :redirect
    assert_redirected_to :action => :index
    assert_equal 'Layout not found', flash[:error]
  end
  
  def test_creation
    assert_difference 'CmsLayout.count' do
      post :create, :cms_layout => {
        :label    => 'Test Layout',
        :content  => 'Test Content'
      }
      assert_response :redirect
      assert_redirected_to :action => :edit, :id => CmsLayout.last
      assert_equal 'Layout successfully created', flash[:notice]
    end
  end
  
  def test_creation_failure
    assert_no_difference 'CmsLayout.count' do
      post :create, :cms_layout => { }
      assert_response :success
      assert_template :new
    end
  end
  
  def test_update
    layout = cms_layouts(:default)
    put :update, :id => layout, :cms_layout => {
      :label    => 'New Label',
      :content  => 'New Content'
    }
    assert_response :redirect
    assert_redirected_to :action => :edit, :id => layout
    assert_equal 'Layout successfully updated', flash[:notice]
    layout.reload
    assert_equal 'New Label', layout.label
    assert_equal 'New Content', layout.content
  end
  
  def test_update_failure
    layout = cms_layouts(:default)
    put :update, :id => layout, :cms_layout => {
      :label    => ''
    }
    assert_response :success
    assert_template :edit
    layout.reload
    assert_not_equal '', layout.label
  end
  
  def test_destroy
    assert_difference 'CmsLayout.count', -1 do
      delete :destroy, :id => cms_layouts(:default)
      assert_response :redirect
      assert_redirected_to :action => :index
      assert_equal 'Layout deleted', flash[:notice]
    end
  end
  
end