require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/bricks/show.html.erb" do
  include BricksHelper
  before(:each) do
    assigns[:brick] = @brick = stub_model(Brick,
      :value => 1,
      :name => "value for name",
      :email => "value for email",
      :url => "value for url",
      :message => "value for message"
    )
  end

  it "should render attributes in <p>" do
    render "/bricks/show.html.erb"
    response.should have_text(/1/)
    response.should have_text(/value\ for\ name/)
    response.should have_text(/value\ for\ email/)
    response.should have_text(/value\ for\ url/)
    response.should have_text(/value\ for\ message/)
  end
end

