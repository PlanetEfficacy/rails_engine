require 'rails_helper'

RSpec.describe ItemSearch, type: :model do
  it "has and id that is a number" do
    params = {"id"=>"200"}
    search = ItemSearch.new(params)

    expect(search.id).to eq(200)
  end

  it "returns an item from the id paramater" do
    item = create(:item)
    params = {"id"=>item.id.to_s}
    search = ItemSearch.new(params)

    expect(search.find).to eq(item)
  end

  it "has a name that is a string" do
    params = {"name" => "thingy"}
    search = ItemSearch.new(params)

    expect(search.name).to eq("thingy")
  end

  it "returns an item from the name paramater" do
    item = create(:item, name: "thingy")
    params = {"name" => "thingy"}
    search = ItemSearch.new(params)

    expect(search.find).to eq(item)
  end

  it "returns an item from the name without regard for case" do
    item = create(:item, name: "thingy")
    params = {"name" => "THINGY"}
    search = ItemSearch.new(params)

    expect(search.find).to eq(item)
  end
end
